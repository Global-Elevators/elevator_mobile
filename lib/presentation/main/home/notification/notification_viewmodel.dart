import 'package:elevator/domain/models/notifications_model.dart';
import 'package:elevator/domain/usecase/delete_notification_usecase.dart';
import 'package:elevator/domain/usecase/notification_usecase.dart';
import 'package:elevator/domain/usecase/read_all_notifications_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends BaseViewModel {
  final NotificationUsecase _notificationUsecase;
  final DeleteNotificationUsecase _deleteNotificationUsecase;
  final ReadAllNotificationsUsecase _readAllNotificationsUsecase;

  NotificationViewModel(
    this._notificationUsecase,
    this._deleteNotificationUsecase,
    this._readAllNotificationsUsecase,
  );

  @override
  void start() => getNotifications();

  NotificationsModel? notificationsModel;

  Future<void> getNotifications() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
    try {
      final result = await _notificationUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message),
          );
        },
        (data) {
          notificationsModel = data;

          final notifications = data.notifications ?? [];

          if (notifications.isEmpty) {
            inputState.add(EmptyState("No notifications found."));
          } else {
            inputState.add(ContentState());
          }
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in getNotifications(): $e\n$stack");
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      final result = await _deleteNotificationUsecase.execute(notificationId);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Notification deleted successfully."));
          getNotifications();
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in deleteNotification(): $e\n$stack");
    }
  }

  Future<void> readAllNotifications() async {

    try {
      final result = await _readAllNotificationsUsecase.execute(null);
      result.fold(
            (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
            (data) {
          inputState.add(SuccessState("All notifications marked as read."));
          getNotifications(); // Refresh notifications after marking all as read
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred while marking notifications as read.",
        ),
      );
      debugPrint("🔥 Exception in readAllNotifications(): $e\n$stack");
    }
  }

}
