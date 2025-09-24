// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..success = json['success'] as bool?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

CustomerDataResponse _$CustomerDataResponseFromJson(
  Map<String, dynamic> json,
) => CustomerDataResponse(
  json['phone'] as String?,
  json['otp_sent'] as bool?,
  json['code'] as String?,
  (json['expires_in'] as num?)?.toInt(),
);

Map<String, dynamic> _$CustomerDataResponseToJson(
  CustomerDataResponse instance,
) => <String, dynamic>{
  'phone': instance.phone,
  'otp_sent': instance.otpSent,
  'code': instance.code,
  'expires_in': instance.expiresIn,
};

VerifyDataResponse _$VerifyDataResponseFromJson(Map<String, dynamic> json) =>
    VerifyDataResponse(
      json['access_token'] as String?,
      json['token_type'] as String?,
    );

Map<String, dynamic> _$VerifyDataResponseToJson(VerifyDataResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
  Map<String, dynamic> json,
) =>
    AuthenticationResponse(
        json['data'] == null
            ? null
            : CustomerDataResponse.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
  AuthenticationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.customerDataResponse,
};

VerifyResponse _$VerifyResponseFromJson(Map<String, dynamic> json) =>
    VerifyResponse(
        json['data'] == null
            ? null
            : VerifyDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VerifyResponseToJson(VerifyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.verifyDataResponse,
    };
