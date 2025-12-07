import 'dart:async';
import 'package:elevator/app/functions.dart';
import 'package:elevator/domain/usecase/reset_password_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class NewPasswordViewModel extends BaseViewModel
    implements NewPasswordViewmodelInputs, NewPasswordViewmodelOutputs {
  final StreamController<String> _userConfirmPasswordController =
          StreamController<String>.broadcast(),
      _userPasswordController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();
  final StreamController<bool>
  didUserEnterPasswordAndConfirmPasswordController =
      StreamController<bool>.broadcast();

  // var loginObject = LoginObject("", "");
  String _password = "", _confirmPassword = "", _token = "";
  final ResetPasswordUsecase _newPasswordUseCase;

  NewPasswordViewModel(this._newPasswordUseCase);

  @override
  void dispose() {
    super.dispose();
    _userConfirmPasswordController.close();
    _userPasswordController.close();
    _areAllInputsValidController.close();
    didUserEnterPasswordAndConfirmPasswordController.close();
  }

  @override
  void start() => inputState.add(ContentState());

  bool _areAllInputsValid() =>
      isTextNotEmpty(_password) && isTextNotEmpty(_confirmPassword);

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Sink get inputConfirmPassword => _userConfirmPasswordController.sink;

  @override
  Sink get inputPassword => _userPasswordController.sink;

  @override
  Stream<bool> get outAreAllDataValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsConfirmPasswordValid => _userConfirmPasswordController
      .stream
      .map((confirmPassword) => isPasswordValid(confirmPassword));

  @override
  Stream<bool> get outIsPasswordValid => _userPasswordController.stream.map(
    (password) => isPasswordValid(password),
  );

  @override
  Future<void> resetPassword() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _newPasswordUseCase.execute(
        ResetPasswordUseCaseInput(_token, _password, _confirmPassword),
      );
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          didUserEnterPasswordAndConfirmPasswordController.add(true);
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
  setUserConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    inputConfirmPassword.add(confirmPassword);
    _areAllInputsValidController.add(null);
  }

  @override
  setUserPassword(String password) {
    _password = password;
    inputPassword.add(password);
    _areAllInputsValidController.add(null);
  }

  @override
  setUserToken(String token) {
    _token = token;
  }
}

abstract class NewPasswordViewmodelInputs {
  setUserPassword(String password);

  setUserConfirmPassword(String confirmPassword);

  setUserToken(String token);

  resetPassword();

  Sink get inputConfirmPassword;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class NewPasswordViewmodelOutputs {
  Stream<bool> get outIsConfirmPasswordValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllDataValid;
}
