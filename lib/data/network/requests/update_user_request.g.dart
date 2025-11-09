// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String,
      birthdate: json['birthdate'] as String?,
      address: json['address'] as String?,
      profileData: json['profile_data'] == null
          ? null
          : UpdateProfileData.fromJson(
        json['profile_data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UpdateUserRequestToJson(
    UpdateUserRequest instance,
    ) => <String, dynamic>{
  'name': instance.name,
  if (instance.email case final value?) 'email': value,
  'phone': instance.phone,
  if (instance.birthdate case final value?) 'birthdate': value,
  if (instance.address case final value?) 'address': value,
  if (instance.profileData?.toJson() case final value?) 'profile_data': value,
};

UpdateProfileData _$UpdateProfileDataFromJson(Map<String, dynamic> json) =>
    UpdateProfileData(
      sirName: json['sir_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$UpdateProfileDataToJson(UpdateProfileData instance) =>
    <String, dynamic>{
      if (instance.sirName case final value?) 'sir_name': value,
      if (instance.lastName case final value?) 'last_name': value,
    };