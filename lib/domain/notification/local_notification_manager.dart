import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';

/// 🧩 LocalNotificationManager
///
/// Responsible for showing local notifications while the app is in the foreground.
/// Uses the singleton pattern to ensure a single instance across the app lifecycle.
class LocalNotificationManager {
  static final LocalNotificationManager _instance = LocalNotificationManager._internal();

  factory LocalNotificationManager() => _instance;

  LocalNotificationManager._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'high_importance_channel';
  static const _channelName = 'High Importance Notifications';
  static const _channelDescription = 'Used for important notifications.';

  /// Initializes local notifications.
  ///
  /// - Creates the Android notification channel.
  /// - Sets up initialization settings for both Android and iOS.
  /// - Ensures this is done only once.
  Future<void> initialize() async {
    if (_initialized) return;

    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.max,
      playSound: true,
    );

    // 🧱 Create notification channel (Android only)
    final androidImplementation = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidImplementation?.createNotificationChannel(androidChannel);

    // 📱 Initialization settings for both platforms
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    // ✅ Initialize plugin safely
    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          debugPrint('📨 Notification tapped: ${response.payload}');
          // TODO: Handle navigation based on payload (if needed)
        }
      },
    );

    _initialized = true;
    debugPrint('✅ LocalNotificationManager initialized successfully');
  }

  /// Displays a local notification with the given parameters.
  ///
  /// Ensures initialization before showing the notification.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    if (!_initialized) {
      debugPrint('⚠️ LocalNotificationManager not initialized yet. Initializing now...');
      await initialize();
    }

    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
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

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );

    debugPrint('🔔 Local notification shown: $title - $body');
  }
}
