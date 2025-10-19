import 'package:elevator/domain/usecase/user_data_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/user_data_model.dart';

class EditInformationViewModel extends BaseViewModel {
  @override
  void start() => getUserData();

  final UserDataUsecase _userDataUsecase;

  EditInformationViewModel(this._userDataUsecase);

  GetUserInfo? userDataModel;

  Future<void> getUserData() async {
    try {
      final result = await _userDataUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message),
          );
        },
        (data) {
          userDataModel = data;
          inputState.add(ContentState());
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
