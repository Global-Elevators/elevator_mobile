// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
  name: json['name'] as String,
  phone: json['phone'] as String,
  birthdate: json['birthdate'] as String,
  password: json['password'] as String,
  profileData: ProfileData.fromJson(
    json['profile_data'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'name': instance.name,
  'phone': instance.phone,
  'birthdate': instance.birthdate,
  'password': instance.password,
  'profile_data': instance.profileData.toJson(),
};

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
  midName: json['mid_name'] as String,
  lastName: json['last_name'] as String,
  address: json['address'] as String,
  interests: json['interests'] as Map<String, dynamic>,
);

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'mid_name': instance.midName,
      'last_name': instance.lastName,
      'address': instance.address,
      'interests': instance.interests,
    };
