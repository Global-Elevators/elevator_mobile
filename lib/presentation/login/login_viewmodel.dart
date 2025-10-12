import 'dart:async';
import 'package:elevator/app/functions.dart';
import 'package:elevator/domain/usecase/login_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/freezed_data_classes.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewmodelInputs, LoginViewmodelOutputs {
  final StreamController<String> _userPhoneController =
          StreamController<String>.broadcast(),
      _userPasswordController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoggedInSuccessfullyController =
      StreamController<bool>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _userPhoneController.close();
    _userPasswordController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyController.close();
  }

  @override
  void start() => inputState.add(ContentState());

  @override
  setUserPhone(String phone) {
    inputPhone.add(phone);
    loginObject = loginObject.copyWith(phone: phone);
    _areAllInputsValidController.add(null);
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _areAllInputsValidController.add(null);
  }

  @override
  Sink get inputPhone => _userPhoneController.sink;

  @override
  Sink get inputPassword => _userPasswordController.sink;

  @override
  Stream<bool> get outIsPhoneValid =>
      _userPhoneController.stream.map((phone) => isTextNotEmpty(phone));

  @override
  Stream<bool> get outIsPasswordValid => _userPasswordController.stream.map(
    (password) => isPasswordValid(password),
  );

  @override
  Future<void> login() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.phone, loginObject.password),
      );
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          isUserLoggedInSuccessfullyController.add(true);

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
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get outAreAllDataValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _areAllInputsValid() =>
      isTextNotEmpty(loginObject.phone) && isPasswordValid(loginObject.password);
}

abstract class LoginViewmodelInputs {
  setUserPhone(String phone);

  setUserPassword(String password);

  login();

  Sink get inputPhone;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewmodelOutputs {
  Stream<bool> get outIsPhoneValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllDataValid;
}
