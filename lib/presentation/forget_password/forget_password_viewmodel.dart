import 'dart:async';
import 'package:elevator/app/functions.dart';
import 'package:elevator/domain/usecase/forget_password_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class ForgetPasswordViewmodel extends BaseViewModel implements ForgetPasswordViewModelInputs, ForgetPasswordViewModelOutputs {
  final StreamController<String> _phoneStreamController =
      StreamController<String>.broadcast();

  StreamController<bool> didTheUserEnterTheCorrectPhoneNumber =
      StreamController<bool>.broadcast();
  String _phone = "";

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgetPasswordViewmodel(this._forgotPasswordUseCase);

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    _phoneStreamController.close();
    didTheUserEnterTheCorrectPhoneNumber.close();
    super.dispose();
  }

  @override
  Future<void> sendVerificationCode() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _forgotPasswordUseCase.execute(_phone);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          didTheUserEnterTheCorrectPhoneNumber.add(true);
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
  Sink get inputPassword => _phoneStreamController.sink;

  @override
  Stream<bool> get outIsPhoneValid =>
      _phoneStreamController.stream.map((phone) => isTextNotEmpty(phone));

  @override
  setUserPhone(String phone) {
    _phone = phone;
    _phoneStreamController.add(phone);
  }
}

abstract class ForgetPasswordViewModelInputs {
  setUserPhone(String phone);

  Sink get inputPassword;

  sendVerificationCode();
}

abstract class ForgetPasswordViewModelOutputs {
  Stream<bool> get outIsPhoneValid;
}
