import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'local_notification_manager.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/domain/usecase/save_fcm_token_usecase.dart';

/// 🔔 PushNotificationManager
///
/// Handles Firebase Cloud Messaging (FCM) events and shows local notifications
/// **only** for foreground messages, since FCM automatically displays
/// notifications in background or terminated states.
@pragma('vm:entry-point')
class PushNotificationManager {
  static final PushNotificationManager _instance =
      PushNotificationManager._internal();

  factory PushNotificationManager() => _instance;

  PushNotificationManager._internal();

  FirebaseMessaging? _messaging;
  final LocalNotificationManager _localNotificationManager =
      LocalNotificationManager();

  bool _initialized = false;

  /// Initializes FCM configuration.
  ///
  /// - Registers the background handler.
  /// - Requests permission to show notifications.
  /// - Retrieves and logs the FCM token.
  Future<void> initialize() async {
    if (_initialized) return; // ✅ prevent reinitialization

    _messaging = FirebaseMessaging.instance; // ✅ now it's safe
    // Register top-level background handler which will show a local notification
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _requestPermission();

    final token = await _messaging?.getToken();
    debugPrint('🔑 FCM Token: $token');

    // If we have a token, save it to the server using the usecase from DI
    if (token != null && token.isNotEmpty) {
      try {
        final result = await instance<SaveFcmTokenUsecase>().execute(token);
        result.fold(
          (failure) =>
              debugPrint('⚠️ Failed to save FCM token: ${failure.message}'),
          (_) => debugPrint('✅ FCM token saved on server'),
        );
      } catch (e) {
        debugPrint('⚠️ Exception when saving FCM token: $e');
      }
    }

    _initialized = true;
  }

  /// Sets up message event listeners for different app states.
  Future<void> setupMessageHandlers() async {
    if (!_initialized) {
      debugPrint('⚠️ PushNotificationManager used before initialization');
      return;
    }

    // 🟢 Foreground messages → handled manually using local notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      if (notification != null) {
        await _localNotificationManager.showNotification(
          id: notification.hashCode,
          title: notification.title ?? 'No Title',
          body: notification.body ?? '',
          payload: message.data.toString(),
        );
        debugPrint('📲 Foreground notification: ${message.data}');
      }
    });

    // 🟡 When user taps a notification (background → foreground)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // 🔴 If app was terminated, check if notification launched it
    final initialMessage = await _messaging?.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }
  }

  Future<void> _requestPermission() async {
    if (_messaging == null) return;
    final settings = await _messaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('🔔 Notification Permission: ${settings.authorizationStatus}');
  }

  /// Handles actions when the user taps on a notification.
  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('📩 Notification opened: ${message.data}');
    // TODO: Navigate or trigger logic based on message.data (if needed)
  }
}

/// Top-level background handler that runs in its own isolate.
/// It initializes its own `FlutterLocalNotificationsPlugin` and shows
/// a local notification so background/terminated messages popup.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Used for important notifications.',
      importance: Importance.max,
      playSound: true,
    );

    // Initialize plugin for the background isolate (Android icon required)
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await plugin.initialize(initSettings);

    final androidImpl = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImpl?.createNotificationChannel(channel);

    final notification = message.notification;
    final title =
        notification?.title ?? message.data['title'] ?? 'Notification';
    final body = notification?.body ?? message.data['body'] ?? '';

    final androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await plugin.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: message.data.toString(),
    );

    debugPrint('📦 Background notification shown: $title - $body');
  } catch (e) {
    debugPrint('⚠️ Error in background handler showing notification: $e');
  }
}
