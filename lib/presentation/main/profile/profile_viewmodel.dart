import 'dart:async';

import 'package:elevator/app/app_pref.dart';
import 'package:elevator/app/dependency_injection.dart';
import 'package:elevator/domain/usecase/logout_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';

class ProfileViewModel extends BaseViewModel {
  final LogoutUsecase _logoutUsecase;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  ProfileViewModel(this._logoutUsecase);

  final StreamController<bool> _logoutSuccessController =
      StreamController<bool>.broadcast();

  Stream<bool> get outLogoutSuccess => _logoutSuccessController.stream;

  void signOut() async {
    try {
      inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
      );

      final result = await _logoutUsecase.execute(null);
      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (_) async {
          await _appPreferences.logOut("login");
          await _appPreferences.logOut("tokenType");
          await _appPreferences.logOut("forget_password");
          inputState.add(SuccessState("Signed out"));
          _logoutSuccessController.add(true);
        },
      );
    } catch (e) {
      inputState.add(
        ErrorState(StateRendererType.popUpErrorState, e.toString()),
      );
    }
  }

  @override
  void dispose() {
    _logoutSuccessController.close();
    super.dispose();
  }

  @override
  void start() {}
}

