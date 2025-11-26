import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/domain/notification/app_notification_manager.dart';
import 'package:elevator/domain/usecase/next_appointment_usecase.dart';
import 'package:elevator/domain/usecase/sos_usecase.dart';
import 'package:elevator/domain/usecase/reschedule_appointment_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';
import 'package:elevator/domain/usecase/user_data_usecase.dart';

class HomeViewmodel extends BaseViewModel implements HomeViewmodelInput {
  String _scheduleDate = '';

  final SosUsecase _sosUsecase;
  final RescheduleAppointmentUsecase _rescheduleAppointmentUsecase;
  final NextAppointmentUsecase _nextAppointmentUsecase;

  final _appPreferences = instance<AppPreferences>();

  HomeViewmodel(
    this._sosUsecase,
    this._rescheduleAppointmentUsecase,
    this._nextAppointmentUsecase,
  );

  // Exposed user name for UI
  String? userName;

  @override
  void start() async {
    bool isUserLoggedInSuccessfully = await _appPreferences.isUserLoggedIn(
      "login",
    );
    if (isUserLoggedInSuccessfully) {
      await AppNotificationManager().initialize();

      // Load next appointment as before
      await getNextAppointment();

      // Also load user data (name) to be displayed in HomeBar

      final userDataUsecase = instance<UserDataUsecase>();
      final result = await userDataUsecase.execute(null);
      result.fold(
        (failure) {
          // ignore - keep userName null
        },
        (data) {
          final name = data.user?.name,
              midName = data.user?.profile?.sirName,
              lastName = data.user?.profile?.lastName;
          if (name != null && name.isNotEmpty) {
            userName = "$name ${midName!} ${lastName!}";
          }
        },
      );

      // Notify listeners/ui that content may have updated
      inputState.add(ContentState());
    }
  }

  @override
  Future<void> sendAlert() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _sosUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          // isUserLoggedInSuccessfullyController.add(true);
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in login(): $e\n$stack");
    }
  }

  @override
  void requestVisitRescheduling() {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      _rescheduleAppointmentUsecase
          .execute(_scheduleDate)
          .then((result) {
            result.fold(
              (failure) {
                inputState.add(
                  ErrorState(
                    StateRendererType.popUpErrorState,
                    failure.message,
                  ),
                );
              },
              (data) {
                inputState.add(SuccessState("Appointment rescheduled"));
              },
            );
          })
          .catchError((e, stack) {
            inputState.add(
              ErrorState(
                StateRendererType.popUpErrorState,
                "Unexpected error occurred. Please try again.",
              ),
            );
            debugPrint("🔥 Exception in requestVisitRescheduling: $e\n$stack");
          });
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in requestVisitRescheduling: $e\n$stack");
    }
  }

  @override
  void setScheduleDate(String scheduleDate) {
    _scheduleDate = scheduleDate;
  }

  NextAppointmentModel? nextAppointmentModel;

  @override
  Future<void> getNextAppointment() async {
    try {
      final result = await _nextAppointmentUsecase.execute(null);
      result.fold(
        (failure) {
          // inputState.add(
          //   ErrorState(StateRendererType.popUpErrorState, failure.message),
          // );
        },
        (data) {
          nextAppointmentModel = data;
          inputState.add(ContentState());
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in login(): $e\n$stack");
    }
  }
}

abstract class HomeViewmodelInput {
  void getNextAppointment();

  void setScheduleDate(String scheduleDate);

  void requestVisitRescheduling();

  void sendAlert();
}
