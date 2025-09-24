import 'dart:async';

import 'package:elevator/domain/usecase/verify_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/freezed_data_classes.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

class VerifyViewModel extends BaseViewModel
    implements VerifyViewmodelInputState, VerifyViewmodelOutputState {
  final VerifyUseCase _verifyUseCase;

  VerifyViewModel(this._verifyUseCase);

  final StreamController<bool> _areAllInputsValidController =
      StreamController<bool>.broadcast();

  final StreamController<bool> isUserLoggedInSuccessfullyController =
      StreamController<bool>.broadcast();

  // String _phone = '', _code = '';
  VerifyObject verifyObject = VerifyObject('', '');

  @override
  void start() => inputState.add(ContentState());

  @override
  void dispose() {
    super.dispose();
    _areAllInputsValidController.close();
    isUserLoggedInSuccessfullyController.close();
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidController.sink;

  @override
  Stream<bool> get areAllInputsValid => _areAllInputsValidController.stream.map(
    (isUserWriteLastNumber) => isUserWriteLastNumber,
  );

  @override
  resend() {}

  @override
  setCode(String code) {
    verifyObject = verifyObject.copyWith(code: code);
  }

  @override
  setPhone(String phone) {
    verifyObject = verifyObject.copyWith(phone: phone);
  }

  @override
  Future<void> verify() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _verifyUseCase.execute(
        VerifyUseCaseInput(verifyObject.phone, verifyObject.code),
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
}

abstract class VerifyViewmodelInputState {
  setPhone(String phone);

  setCode(String code);

  verify();

  resend();

  Sink get inputAreAllInputsValid;
}

abstract class VerifyViewmodelOutputState {
  Stream<bool> get areAllInputsValid;
}
