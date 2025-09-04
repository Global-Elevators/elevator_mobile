import 'dart:async';
import 'dart:io';

import 'package:elevator/app/functions.dart';
import 'package:elevator/domain/usecase/register_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/freezed_data_classes.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInputs, RegisterViewModelOutPuts {
  final StreamController<String> _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _mobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<File> _profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController<bool> isUserRegisteredInSuccessfullyStreamController =
      StreamController<bool>();
  final StreamController _areAllFieldsValidStreamController =
      StreamController<void>.broadcast();
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  var registerObject = RegisterObject("", "", "", "", "");

  @override
  void start() {}

  @override
  void dispose() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _mobileNumberStreamController.close();
    _profilePictureStreamController.close();
    _areAllFieldsValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
  }

  // inputs
  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => _profilePictureStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllFieldsValid => _areAllFieldsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outputAreAllFieldsValid => _areAllFieldsValidStreamController
      .stream
      .map((_) => _areAllFieldsValid());

  @override
  Stream<File> get outputProfilePicture => _profilePictureStreamController
      .stream
      .map((profilePicture) => profilePicture);

  @override
  Stream<bool> get outputIsEmail =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmail.map(
    (isEmailValid) => isEmailValid ? null : Strings.emailError,
  );

  @override
  Stream<bool> get outputIsMobileNumber => _mobileNumberStreamController.stream
      .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumber.map(
    (isMobileNumberValid) =>
        isMobileNumberValid ? null : Strings.mobileNumberError,
  );

  @override
  Stream<bool> get outputIsPassword => _passwordStreamController.stream.map(
    (password) => _isPasswordValid(password),
  );

  @override
  Stream<String?> get outputErrorPassword => outputIsPassword.map(
    (isPasswordValid) => isPasswordValid ? null : Strings.passwordValid,
  );

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid.map(
    (isUserNameValid) => isUserNameValid ? null : Strings.userNameError,
  );

  @override
  register() async {
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        registerObject.userName,
        registerObject.userName,
        registerObject.email,
        registerObject.password,
        registerObject.profilePicture,
      ),
    )).fold((failure) {
    }, (success) {});
  }

  // Setters

  @override
  setEmail(String email) {}

  @override
  setMobileNumber(String mobileNumber) {}

  @override
  setPassword(String password) {}

  @override
  setProfilePicture(File profilePicture) {}

  @override
  setUserName(String userName) {}

  // Private functions
  bool _isUserNameValid(String userName) => userName.length >= 8;

  bool _isMobileNumberValid(String phoneNumber) => phoneNumber.length >= 10;

  bool _isPasswordValid(String password) => password.length >= 6;

  bool _areAllFieldsValid() {
    // return registerObject.email.isNotEmpty &&
    //     registerObject.password.isNotEmpty &&
    //     registerObject.userName.isNotEmpty &&
    //     registerObject.mobileNumber.isNotEmpty &&
    //     registerObject.profilePicture.isNotEmpty &&
    //     registerObject.countryMobileCode.isNotEmpty;
    return true;
  }

  // validate() => inputAllFieldsValid.add(null); // why we add null? because we don't need to send any data to the stream
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputMobileNumber;

  Sink get inputProfilePicture;

  Sink get inputAllFieldsValid;

  setUserName(String userName);

  setEmail(String email);

  setPassword(String password);

  setMobileNumber(String mobileNumber);

  setProfilePicture(File profilePicture);

  register();
}

abstract class RegisterViewModelOutPuts {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsEmail;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPassword;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputIsMobileNumber;

  Stream<String?> get outputErrorMobileNumber;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllFieldsValid;
}
