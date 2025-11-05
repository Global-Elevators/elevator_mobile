import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/notifications_model.dart';
import 'package:elevator/app/extensions.dart';

extension NotificationResponseMapper on NotificationsResponse? {
  NotificationsModel toDomain() {
    return NotificationsModel(
      this?.notificationDataResponse?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension NotificationDataResponseMapper on NotificationDataResponse? {
  NotificationData toDomain() {
    return NotificationData(
      this?.id.orEmpty() ?? Constants.empty,
      this?.type.orEmpty() ?? Constants.empty,
      this?.title.orEmpty() ?? Constants.empty,
      this?.body.orEmpty() ?? Constants.empty,
    );
  }
}