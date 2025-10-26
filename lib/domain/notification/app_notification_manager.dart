import 'package:elevator/domain/notification/local_notification_manager.dart';
import 'package:elevator/domain/notification/push_notification_manager.dart';

class AppNotificationManager {
  static final AppNotificationManager _instance = AppNotificationManager._();
  factory AppNotificationManager() => _instance;
  AppNotificationManager._();

  final _pushManager = PushNotificationManager();
  final _localManager = LocalNotificationManager();

  Future<void> initialize() async {
    await _localManager.initialize();
    await _pushManager.initialize();
    await _pushManager.setupMessageHandlers();
  }
}
