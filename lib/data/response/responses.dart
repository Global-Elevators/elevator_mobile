import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerDataResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "otp_sent")
  bool? otpSent;
  @JsonKey(name: "code")
  String? code;
  @JsonKey(name: "expires_in")
  int? expiresIn;

  CustomerDataResponse(this.phone, this.otpSent, this.code, this.expiresIn);

  factory CustomerDataResponse.fromJson(Map<String, dynamic> json) => _$CustomerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataResponseToJson(this);
}

@JsonSerializable()
class VerifyDataResponse {
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "token_type")
  String? tokenType;

  VerifyDataResponse(this.accessToken, this.tokenType);

  factory VerifyDataResponse.fromJson(Map<String, dynamic> json) => _$VerifyDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  CustomerDataResponse? customerDataResponse;

  AuthenticationResponse(this.customerDataResponse);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class VerifyResponse extends BaseResponse {
  @JsonKey(name: "data")
  VerifyDataResponse? verifyDataResponse;

  VerifyResponse(this.verifyDataResponse);

  factory VerifyResponse.fromJson(Map<String, dynamic> json) => _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}