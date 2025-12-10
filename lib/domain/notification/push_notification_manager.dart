import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
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
  /// - Disables auto-notification display to prevent duplicates.
  /// - Registers the background handler.
  /// - Requests permission to show notifications.
  /// - Retrieves and logs the FCM token.
  Future<void> initialize() async {
    if (_initialized) return; // ✅ prevent reinitialization

    _messaging = FirebaseMessaging.instance; // ✅ now it's safe

    // Enable presentation on iOS to show notifications as a popup in foreground.
    // We avoid duplicating notifications by skipping local display on iOS
    // when the notification payload is present.
    await _messaging!.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

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
      final title = notification?.title ?? message.data['title'];
      final body = notification?.body ?? message.data['body'];

      final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

      // On iOS, when a `notification` payload is present let the system
      // present the notification (the call to setForegroundNotificationPresentationOptions controls visibility). This avoids duplicates.
      if (isIOS && notification != null) {
        debugPrint(
          '📲 iOS foreground notification present — letting the system display it.',
        );
        return;
      }

      if (title != null || body != null) {
        final id =
            message.messageId?.hashCode ??
            (notification?.hashCode ?? message.data.hashCode);
        await _localNotificationManager.showNotification(
          id: id,
          title: title ?? 'No Title',
          body: body ?? '',
          payload: message.data.toString(),
        );
        debugPrint('📲 Foreground notification shown by app: ${message.data}');
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

    const fcmFallbackChannel = AndroidNotificationChannel(
      'fcm_fallback_notification_channel',
      'FCM Fallback Channel',
      description: 'Used for Firebase Console fallback notifications',
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
    await androidImpl?.createNotificationChannel(fcmFallbackChannel);

    final notification = message.notification;
    final title =
        notification?.title ?? message.data['title'] ?? 'Notification';
    final body = notification?.body ?? message.data['body'] ?? '';

    // Log details to help diagnose duplicates (optional)
    debugPrint(
      '📦 Background message received: id=${message.messageId}, notification=${message.notification}, dataKeys=${message.data.keys}',
    );
    debugPrint('📦 Background message data: ${message.data}');

    // Detect if this message was already displayed by FCM (system) —
    // Firebase Console / FCM may deliver a notification via system tray and
    // also deliver the data payload to the background isolate. In that
    // case, message.notification will often be null but data will contain
    // FCM internals (google.c.* keys). When found, skip local showing.
    final data = message.data;
    final systemKeys = [
      'google.c.a.e',
      'google.c.a.c_id',
      'google.c.a.c_l',
      'gcm.message_id',
      'google.message_id',
      'from',
      'notification',
    ];
    bool looksLikeSystemNotification = false;
    for (final k in systemKeys) {
      if (data.containsKey(k)) {
        looksLikeSystemNotification = true;
        break;
      }
    }

    // Also detect keys that start with 'google.c.' which are often included by
    // Firebase when a 'notification' payload was originally sent (console or
    // server). These keys indicate the platform already created a system
    // notification and the background isolate only receives the data.
    if (!looksLikeSystemNotification) {
      for (final k in data.keys) {
        if (k.startsWith('google.c.')) {
          looksLikeSystemNotification = true;
          break;
        }
      }
    }

    // If the FCM message includes a `notification` payload, the platform
    // already shows a system notification in background/terminated states.
    // If the message uses our high importance channel, skip local display.
    if (notification != null) {
      final channelId = message.notification?.android?.channelId;
      final usesOurHighImportanceChannel =
          channelId == 'high_importance_channel';
      if (usesOurHighImportanceChannel || looksLikeSystemNotification) {
        debugPrint(
          'ℹ️ Notification payload detected; system likely handles presentation — skipping local notification.',
        );
        return;
      }
      // Fall through — allow local display if explicitly requested by the server
      // (show_local flag) to ensure a heads-up popup for messages that would
      // otherwise show in a low-priority system channel.
    }

    if (looksLikeSystemNotification) {
      debugPrint(
        'ℹ️ Background message looks like it was already shown by system; skipping local notification to avoid duplicate.',
      );
      return;
    }

    // Only allow client-side (background) local notifications if server
    // explicitly requests it using the `show_local` flag in `data`.
    // This prevents duplicates when the server sends a `notification`
    // payload (which the platform already shows).
    final shouldShowLocal = data['show_local'] == 'true';
    if (!shouldShowLocal) {
      debugPrint(
        'ℹ️ show_local flag not present or false; skipping local display in background (avoid duplicates).',
      );
      return;
    }

    // Use message ID as stable notification ID to prevent duplicate re-shows
    final notificationId =
        message.messageId?.hashCode ??
        (message.notification?.hashCode ?? message.data.hashCode);

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
      notificationId,
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
