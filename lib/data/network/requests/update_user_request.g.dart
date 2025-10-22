// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    UpdateUserRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      birthdate: json['birthdate'] as String,
      address: json['address'] as String,
      profileData: UpdateProfileData.fromJson(
        json['profile_data'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$UpdateUserRequestToJson(UpdateUserRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'birthdate': instance.birthdate,
      'address': instance.address,
      'profile_data': instance.profileData?.toJson(),
    };

UpdateProfileData _$UpdateProfileDataFromJson(Map<String, dynamic> json) =>
    UpdateProfileData(
      sirName: json['sir_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$UpdateProfileDataToJson(UpdateProfileData instance) =>
    <String, dynamic>{
      'sir_name': instance.sirName,
      'last_name': instance.lastName,
    };
