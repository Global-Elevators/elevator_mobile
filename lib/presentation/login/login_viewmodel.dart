import 'dart:async';
import 'package:elevator/domain/usecase/login_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel implements LoginViewmodelInputs, LoginViewmodelOutputs {
  final StreamController<String> _userPhoneController =
          StreamController<String>.broadcast(),
      _userPasswordController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();

  // final StreamController<bool> isUserLoggedInSuccessfullyStreamController = StreamController<bool>();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    // super.dispose();
    _userPhoneController.close();
    _userPasswordController.close();
    _areAllInputsValidController.close();
    // isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {}

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
      _userPhoneController.stream.map((password) => _isPhoneValid(password));

  @override
  Stream<bool> get outIsPasswordValid => _userPasswordController.stream.map(
    (password) => _isPasswordValid(password),
  );

  bool _isPhoneValid(String phone) {
    // final iraqPhoneRegex = RegExp(r'^(?:\+964|0)(7[3-9]\d{8})$');
    // return iraqPhoneRegex.hasMatch(phone);
    return phone.isNotEmpty;
  }

  bool _isPasswordValid(String password) => password.isNotEmpty;

  @override
  login() async {
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.phone, loginObject.password),
    )).fold((failure) {
      print(failure.message);
      print(failure.code);
    }, (data) {
      print(data.customer!.phone);
    });
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get outAreAllDataValid =>
      _areAllInputsValidController.stream.map((_) => _areAllInputsValid());

  bool _areAllInputsValid() =>
      _isPhoneValid(loginObject.phone) &&
      _isPasswordValid(loginObject.password);
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
  // We return bool to indicate if the user write his email and password then the button will be valid to click
  Stream<bool> get outIsPhoneValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreAllDataValid;
}
