import 'package:json_annotation/json_annotation.dart';
part 'update_user_request.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UpdateUserRequest {
  final String name;
  final String? email;
  final String phone;
  final String? birthdate;
  final String? address;

  @JsonKey(name: 'profile_data')
  final UpdateProfileData? profileData;

  UpdateUserRequest({
    required this.name,
    required this.email,
    required this.phone,
    required this.birthdate,
    required this.address,
    required this.profileData,
  });

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UpdateProfileData {
  @JsonKey(name: 'sir_name')
  final String? sirName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  const UpdateProfileData({
    required this.sirName,
    required this.lastName,
  });

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileDataToJson(this);
}
