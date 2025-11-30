import 'package:easy_localization/easy_localization.dart';
import 'package:elevator/domain/usecase/user_data_usecase.dart';
import 'package:elevator/domain/usecase/update_data_usecase.dart';
import 'package:elevator/presentation/base/baseviewmodel.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer.dart';
import 'package:elevator/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:elevator/presentation/resources/strings_manager.dart';
import '../../../../domain/models/user_data_model.dart';
import 'package:elevator/data/network/requests/update_user_request.dart';

class EditInformationViewModel extends BaseViewModel {
  final UserDataUsecase _userDataUsecase;
  final UpdateDataUsecase _updateDataUsecase;

  EditInformationViewModel(this._userDataUsecase, this._updateDataUsecase);

  GetUserInfo? userDataModel;

  @override
  void start() => getUserData();

  // ------------------ FETCH USER ------------------
  Future<void> getUserData() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState),
    );

    final result = await _userDataUsecase.execute(null);

    result.fold(
      (failure) => inputState.add(
        ErrorState(StateRendererType.fullScreenErrorState, failure.message),
      ),
      (data) {
        userDataModel = data;
        inputState.add(ContentState());
      },
    );
  }

  // ------------------ UPDATE USER ------------------
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

    final request = UpdateUserRequest(
      name: name,
      email: email?.isNotEmpty == true ? email : null,
      phone: phone,
      birthdate: _normalizeBirthdate(birthdate),
      address: address.isNotEmpty ? address : null,
      profileData: UpdateProfileData(sirName: sirName, lastName: lastName),
    );

    final result = await _updateDataUsecase.execute(request);

    await result.fold(
      (failure) {
        inputState.add(
          ErrorState(StateRendererType.popUpErrorState, failure.message),
        );
      },
      (_) async {
        final updated = await _userDataUsecase.execute(null);

        updated.fold(
          (failure) => inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message),
          ),
          (data) {
            userDataModel = data;

            inputState.add(ContentState());

            inputState.add(
              SuccessState(Strings.profileInformationRequestSent.tr()),
            );
          },
        );
      },
    );
  }

  String? _normalizeBirthdate(String raw) {
    try {
      final dt = DateTime.parse(raw);
      return DateFormat("yyyy-MM-dd").format(dt);
    } catch (_) {
      return raw;
    }
  }
}
