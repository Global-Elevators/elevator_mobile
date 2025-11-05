import 'package:elevator/domain/models/notifications_model.dart';
import 'package:elevator/domain/usecase/notification_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends BaseViewModel {
  final NotificationUsecase _notificationUsecase;

  NotificationViewModel(this._notificationUsecase);

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
}
