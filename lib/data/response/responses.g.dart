// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};

CustomerDataResponse _$CustomerDataResponseFromJson(
  Map<String, dynamic> json,
) => CustomerDataResponse(
  json['id'] as String?,
  json['name'] as String?,
  json['profilePicture'] as String?,
  json['token'] as String?,
);

Map<String, dynamic> _$CustomerDataResponseToJson(
  CustomerDataResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'profilePicture': instance.profilePicture,
  'token': instance.token,
};

ContactsDataResponse _$ContactsDataResponseFromJson(
  Map<String, dynamic> json,
) => ContactsDataResponse(json['phone'] as String?, json['email'] as String?);

Map<String, dynamic> _$ContactsDataResponseToJson(
  ContactsDataResponse instance,
) => <String, dynamic>{'phone': instance.phone, 'email': instance.email};

AuthenticationResponse _$AuthenticationResponseFromJson(
  Map<String, dynamic> json,
) =>
    AuthenticationResponse(
        json['customer'] == null
            ? null
            : CustomerDataResponse.fromJson(
                json['customer'] as Map<String, dynamic>,
              ),
        json['contacts'] == null
            ? null
            : ContactsDataResponse.fromJson(
                json['contacts'] as Map<String, dynamic>,
              ),
      )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
  AuthenticationResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'customer': instance.customerDataResponse,
  'contacts': instance.contactsDataResponse,
};
