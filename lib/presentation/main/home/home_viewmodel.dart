import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
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
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:elevator/domain/usecase/user_data_usecase.dart';

class HomeViewmodel extends BaseViewModel implements HomeViewmodelInput {
  String _scheduleDate = '';

  final SosUsecase _sosUsecase;
  final RescheduleAppointmentUsecase _rescheduleAppointmentUsecase;
  final NextAppointmentUsecase _nextAppointmentUsecase;
  final UserDataUsecase _userDataUsecase;

  final _appPreferences = instance<AppPreferences>();

  HomeViewmodel(
    this._sosUsecase,
    this._rescheduleAppointmentUsecase,
    this._nextAppointmentUsecase,
    this._userDataUsecase,
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

      // Load user data first (will use cache if available)
      await _loadUserData();

      // Load next appointment
      await getNextAppointment();

      // Notify listeners/ui that content is ready
      inputState.add(ContentState());
    }
  }

  /// Loads user data from cache or remote source
  /// This method doesn't show loading state - it loads silently
  Future<void> _loadUserData() async {
    try {
      final result = await _userDataUsecase.execute(null);
      result.fold(
        (failure) {
          // Keep userName null on failure
          debugPrint("Failed to load user data: ${failure.message}");
        },
        (data) {
          final name = data.user?.name;
          final midName = data.user?.profile?.sirName;
          final lastName = data.user?.profile?.lastName;

          if (name != null && name.isNotEmpty) {
            userName = "$name ${midName ?? ''} ${lastName ?? ''}".trim();
            // Notify UI immediately when userName is loaded
            inputState.add(ContentState());
          }
        },
      );
    } catch (e, stack) {
      debugPrint("Exception loading user data: $e\n$stack");
    }
  }

  /// Public method to refresh user data (e.g., after profile update)
  Future<void> refreshUserData() async {
    await _loadUserData();
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
          inputState.add(SuccessState(Strings.alertSentSuccessfully.tr()));
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in sendAlert(): $e\n$stack");
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
                inputState.add(
                  SuccessState(Strings.appointmentRescheduledSuccessfully.tr()),
                );
              },
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              inputState.add(ContentState());
            });
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

  /// Returns the currently selected schedule date (as stored string), if any.
  String get scheduleDate => _scheduleDate;

  NextAppointmentModel? nextAppointmentModel;

  @override
  Future<void> getNextAppointment() async {
    try {
      final result = await _nextAppointmentUsecase.execute(null);
      result.fold(
        (failure) {
          // Silently fail - don't show error for appointment
          debugPrint("Failed to load next appointment: ${failure.message}");
        },
        (data) {
          nextAppointmentModel = data;
          inputState.add(ContentState());
        },
      );
    } catch (e, stack) {
      debugPrint("🔥 Exception in getNextAppointment(): $e\n$stack");
    }
  }
}

abstract class HomeViewmodelInput {
  void getNextAppointment();

  void setScheduleDate(String scheduleDate);

  void requestVisitRescheduling();

  void sendAlert();
}
