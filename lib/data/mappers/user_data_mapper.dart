import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/user_data_model.dart';
import 'package:elevator/app/extensions.dart';

extension UserProfileResponseMapper on UserProfileDataResponse? {
  UserProfile toDomain() {
    return UserProfile(
      this?.sirName.orEmpty() ?? Constants.empty,
      this?.lastName.orEmpty() ?? Constants.empty,
    );
  }
}

extension UserResponseMapper on UserDataResponse? {
  User toDomain() {
    return User(
      this?.id.orZero() ?? Constants.zero,
      this?.name.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.address.orEmpty() ?? Constants.empty,
      this?.birthdate.orEmpty() ?? Constants.empty,
      this?.profileData.toDomain(),
    );
  }
}

extension UserInfoResponseMapper on GetUserResponse? {
  GetUserInfo toDomain() {
    return GetUserInfo(this?.userDataResponse.toDomain());
  }
}