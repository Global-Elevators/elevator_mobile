import 'dart:async';

import 'package:elevator/domain/usecase/login_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewmodelInputs, LoginViewmodelOutputs {
  final StreamController<String> _userEmailController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordEmailController =
      StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();
  final StreamController<bool> isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    // super.dispose();
    _userEmailController.close();
    _passwordEmailController.close();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // inputState.add(ContentState());
  }

  @override
  setUserEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    _areAllInputsValidController.add(null);
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _areAllInputsValidController.add(null);
  }

  @override
  Sink get inputEmail => _userEmailController.sink;

  @override
  Sink get inputPassword => _passwordEmailController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _userEmailController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsPasswordValid => _passwordEmailController.stream.map(
    (password) => _isPasswordValid(password),
  );

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  login() async {
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.email, loginObject.password),
    )).fold((failure) {}, (success) {});
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get outAreAllDataValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return true;
  }
}

abstract class LoginViewmodelInputs {
  setUserEmail(String email);

  setUserPassword(String password);

  login();

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewmodelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllDataValid;
}
