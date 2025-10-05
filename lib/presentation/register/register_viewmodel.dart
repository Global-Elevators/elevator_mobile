import 'dart:async';
import 'dart:developer';
import 'package:elevator/app/functions.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/domain/usecase/register_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  final StreamController<String> _nameController =
          StreamController<String>.broadcast(),
      _fatherNameController = StreamController<String>.broadcast(),
      _grandFatherNameController = StreamController<String>.broadcast(),
      _phoneNumberController = StreamController<String>.broadcast(),
      _passwordController = StreamController<String>.broadcast(),
      _confirmPasswordController = StreamController<String>.broadcast(),
      _emailController = StreamController<String>.broadcast();
  final StreamController<void> _areAllInputsValidController =
      StreamController<void>.broadcast();

  final StreamController<bool> isUserRegisteredSuccessfullyController =
      StreamController<bool>.broadcast();

  String _name = '',
      _fatherName = '',
      _grandFatherName = '',
      _phoneNumber = '',
      _password = '',
      _confirmPassword = '',
      _birthDate = '',
      _email = '',
      _address = '';

  @override
  void dispose() {
    super.dispose();
    _nameController.close();
    _fatherNameController.close();
    _grandFatherNameController.close();
    _phoneNumberController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _emailController.close();
    _areAllInputsValidController.close();
  }

  @override
  void start() => inputState.add(ContentState());

  @override
  Stream<bool> get areAllInputsValidStream =>
      _areAllInputsValidController.stream.map((name) => _areAllInputsValid());

  @override
  Stream<bool> get outIsConfirmPasswordValid => _confirmPasswordController
      .stream
      .map((confirmPassword) => isPhoneValid(confirmPassword));

  @override
  Stream<bool> get outIsFatherNameValid => _fatherNameController.stream.map(
    (fatherName) => isPhoneValid(fatherName),
  );

  @override
  Stream<bool> get outIsGrandFatherNameValid => _grandFatherNameController
      .stream
      .map((grandFatherName) => isPhoneValid(grandFatherName));

  @override
  Sink get inPutConfirmPassword => _confirmPasswordController.sink;

  @override
  Sink get inPutFatherName => _fatherNameController.sink;

  @override
  Sink get inPutGrandFatherName => _grandFatherNameController.sink;

  @override
  Sink get inPutName => _nameController.sink;

  @override
  Sink get inPutPassword => _passwordController.sink;

  @override
  Sink get inPutPhoneNumber => _phoneNumberController.sink;

  @override
  Stream<bool> get outIsNameValid =>
      _nameController.stream.map((name) => isPhoneValid(name));

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordController.stream.map((password) => isPhoneValid(password));

  @override
  Stream<bool> get outIsPhoneNumberValid => _phoneNumberController.stream.map(
    (phoneNumber) => isPhoneValid(phoneNumber),
  );

  @override
  Future<void> register() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final profileData = ProfileData(
        midName: _fatherName,
        lastName: _grandFatherName,
        address: _address,
        interests: {},
      );
      final userData = UserData(
        name: _name,
        phone: _phoneNumber,
        birthdate: _birthDate,
        password: _password,
        profileData: profileData,
      );

      final result = await _registerUseCase.execute(userData);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
          log(failure.message);
        },
        (data) {
          inputState.add(SuccessState("Welcome back"));
          log("Welcome back");
          isUserRegisteredSuccessfullyController.add(true);
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

  // Setters
  @override
  void setConfirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    inPutConfirmPassword.add(confirmPassword);
    _areAllInputsValidController.add(null);
  }

  @override
  void setFatherName(String fatherName) {
    _fatherName = fatherName;
    inPutFatherName.add(fatherName);
    _areAllInputsValidController.add(null);
  }

  @override
  void setGrandFatherName(String grandFatherName) {
    _grandFatherName = grandFatherName;
    inPutGrandFatherName.add(grandFatherName);
    _areAllInputsValidController.add(null);
  }

  @override
  void setName(String name) {
    _name = name;
    inPutName.add(name);
    _areAllInputsValidController.add(null);
  }

  @override
  void setPassword(String password) {
    _password = password;
    inPutPassword.add(password);
    _areAllInputsValidController.add(null);
  }

  @override
  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    inPutPhoneNumber.add(phoneNumber);
    _areAllInputsValidController.add(null);
  }

  @override
  void setBirthDate(String birthDate) {
    _birthDate = birthDate;
    _areAllInputsValidController.add(null);
  }

  @override
  void setEmail(String email) {
    _email = email;
    inPutEmail.add(email);
    _areAllInputsValidController.add(null);
  }

  @override
  Sink get areAllInputsValidController => _areAllInputsValidController.sink;

  bool _areAllInputsValid() =>
      isPhoneValid(_name) &&
      isPhoneValid(_fatherName) &&
      isPhoneValid(_grandFatherName) &&
      // isPhoneValid(_email) &&
      isPhoneValid(_phoneNumber) &&
      isPhoneValid(_password) &&
      isPhoneValid(_confirmPassword) &&
      isPhoneValid(_birthDate) &&
      isPhoneValid(_address);

  @override
  Sink get inPutEmail => _emailController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _emailController.stream.map((email) => isPhoneValid(email));

  @override
  void setAddress(String address) {
    _address = address;
    _areAllInputsValidController.add(null);
  }
}

abstract class RegisterViewModelInput {
  void register();

  void setName(String name);

  void setFatherName(String fatherName);

  void setGrandFatherName(String grandFatherName);

  void setPhoneNumber(String phoneNumber);

  void setPassword(String password);

  void setConfirmPassword(String confirmPassword);

  void setBirthDate(String birthDate);

  void setEmail(String email);

  void setAddress(String address);

  Sink get inPutName;

  Sink get inPutFatherName;

  Sink get inPutGrandFatherName;

  Sink get inPutPhoneNumber;

  Sink get inPutPassword;

  Sink get inPutConfirmPassword;

  Sink get inPutEmail;

  Sink get areAllInputsValidController;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get areAllInputsValidStream;

  Stream<bool> get outIsNameValid;

  Stream<bool> get outIsFatherNameValid;

  Stream<bool> get outIsGrandFatherNameValid;

  Stream<bool> get outIsPhoneNumberValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outIsConfirmPasswordValid;

  Stream<bool> get outIsEmailValid;
}
