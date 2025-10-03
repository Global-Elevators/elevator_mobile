import 'dart:async';
import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/domain/usecase/resend_otp_usecase.dart';
import 'package:elevator/domain/usecase/verify_forgot_password_usecase.dart';
import 'package:elevator/domain/usecase/verify_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class VerifyViewModel extends BaseViewModel
    implements VerifyViewmodelInputState, VerifyViewmodelOutputState {
  final VerifyUseCase _verifyUseCase;
  final VerifyForgotPasswordUseCase _verifyForgotPasswordUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final _appPref = instance<AppPreferences>();

  VerifyViewModel(
    this._verifyUseCase,
    this._verifyForgotPasswordUseCase,
    this._resendOtpUseCase,
  );

  final StreamController<bool> _areAllInputsValidController =
      StreamController<bool>.broadcast();

  final StreamController<bool> isUserEnterVerifyCodeSuccessfullyController =
      StreamController<bool>.broadcast();

  String _phone = '', _code = '';

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    super.dispose();
    _areAllInputsValidController.close();
    isUserEnterVerifyCodeSuccessfullyController.close();
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get areAllInputsValid => _areAllInputsValidController.stream.map(
    (isUserWriteLastNumber) => isUserWriteLastNumber,
  );

  @override
  Future<void> resend() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _resendOtpUseCase.execute(_phone);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Otp resend successfully"));
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
  setCode(String code) => _code = code;

  @override
  setPhone(String phone) => _phone = phone;

  @override
  Future<void> verify() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _verifyUseCase.execute(
        VerifyUseCaseInput(_phone, _code),
      );
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Otp verified successfully"));
          _appPref.setUserToken("login", "55555");
          isUserEnterVerifyCodeSuccessfullyController.add(true);
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
  Future<void> verifyForgotPassword() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _verifyForgotPasswordUseCase.execute(
        VerifyForgotPasswordUseCaseInput(_phone, _code),
      );
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          _appPref.setUserToken(
            "forget_password",
            data.verifyForgotPasswordDataModel!.token,
          );
          isUserEnterVerifyCodeSuccessfullyController.add(true);
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

abstract class VerifyViewmodelInputState {
  setPhone(String phone);

  setCode(String code);

  verify();

  verifyForgotPassword();

  resend();

  Sink get inputAreAllInputsValid;
}

abstract class VerifyViewmodelOutputState {
  Stream<bool> get areAllInputsValid;
}
