import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/domain/usecase/user_data_usecase.dart';
import 'package:elevator/domain/usecase/update_data_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import '../../../../domain/models/user_data_model.dart';
import 'package:elevator/data/network/requests/update_user_request.dart';

class EditInformationViewModel extends BaseViewModel {
  @override
  void start() => getUserData();

  final UserDataUsecase _userDataUsecase;
  final UpdateDataUsecase _updateDataUsecase;

  EditInformationViewModel(this._userDataUsecase, this._updateDataUsecase);

  GetUserInfo? userDataModel;

  Future<void> getUserData() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );
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
      debugPrint("🔥 Exception in getUserData(): $e\n$stack");
    }
  }

  String _normalizeBirthdate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '';
    final s = raw.trim();
    // Try ISO parse first
    try {
      final dt = DateTime.parse(s);
      return DateFormat('yyyy-MM-dd').format(dt);
    } catch (_) {}

    // Try common d-m-y or d/m/y or y-m-d patterns
    final parts = s.split(RegExp(r'[-/]'));
    if (parts.length == 3) {
      try {
        if (parts[0].length == 4) {
          // yyyy-mm-dd
          final dt = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
          return DateFormat('yyyy-MM-dd').format(dt);
        } else {
          // assume dd-mm-yyyy
          final dt = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
          return DateFormat('yyyy-MM-dd').format(dt);
        }
      } catch (_) {}
    }
    return s;
  }

  Future<void> updateUserData(
    String name,
    String? email,
    String phone,
    String birthdate,
    String address,
    String sirName,
    String lastName,
  ) async {

    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popUpLoadingState),
    );

    try {
      final profile = UserProfile(sirName, lastName);
      final user = User(0, name, email, phone, address, birthdate, profile);

      final profileData = UpdateProfileData(
        sirName: profile.sirName,
        lastName: profile.lastName,
      );

      final normalizedBirth = _normalizeBirthdate(user.birthdate);

      final request = UpdateUserRequest(
        name: user.name,
        email: (user.email != null && user.email!.isNotEmpty)
            ? user.email
            : null,
        phone: user.phone,
        birthdate: normalizedBirth.isNotEmpty ? normalizedBirth : null,
        address: (user.address.isNotEmpty) ? user.address : null,
        profileData: profileData,
      );

      final result = await _updateDataUsecase.execute(request);

      result.fold(
        (failure) {
          inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          );
        },
        (_) async {
          await getUserData();
          inputState.add(SuccessState(Strings.profileInformationRequestSent.tr()));
        },
      );
    } catch (e, stack) {
      inputState.add(
        ErrorState(
          StateRendererType.popUpErrorState,
          "Unexpected error occurred. Please try again.",
        ),
      );
      debugPrint("🔥 Exception in updateUserData(): $e\n$stack");
    }
  }
}
