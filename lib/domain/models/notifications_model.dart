class NotificationsModel {
  List<NotificationData> notifications;

  NotificationsModel(this.notifications);
}

class NotificationData {
  String id;
  String type;
  String title;
  String body;

  NotificationData(this.id, this.type, this.title, this.body);
}
