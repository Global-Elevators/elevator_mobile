import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  final String name;
  final String phone;
  final String birthdate;
  final String password;

  @JsonKey(name: 'profile_data')
  final ProfileData profileData;

  UserData({
    required this.name,
    required this.phone,
    required this.birthdate,
    required this.password,
    required this.profileData,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class ProfileData {
  @JsonKey(name: 'mid_name')
  final String midName;

  @JsonKey(name: 'last_name')
  final String lastName;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'interests')
  final Map<String, dynamic> interests;

  const ProfileData({
    required this.midName,
    required this.lastName,
    required this.address,
    required this.interests,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataToJson(this);
}
