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

  factory CustomerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataResponseToJson(this);
}

@JsonSerializable()
class LoginResponse extends BaseResponse {
  @JsonKey(name: "data")
  CustomerDataResponse? customerDataResponse;

  LoginResponse(this.customerDataResponse);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class VerifyDataResponse {
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "token_type")
  String? tokenType;

  VerifyDataResponse(this.accessToken, this.tokenType);

  factory VerifyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyDataResponseToJson(this);
}

@JsonSerializable()
class VerifyResponse extends BaseResponse {
  @JsonKey(name: "data")
  VerifyDataResponse? verifyDataResponse;

  VerifyResponse(this.verifyDataResponse);

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}

@JsonSerializable()
class VerifyForgotPasswordDataResponse {
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "expires_in")
  int? expiresIn;

  VerifyForgotPasswordDataResponse(this.token, this.expiresIn);

  factory VerifyForgotPasswordDataResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$VerifyForgotPasswordDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VerifyForgotPasswordDataResponseToJson(this);
}

@JsonSerializable()
class VerifyForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "data")
  VerifyForgotPasswordDataResponse? verifyForgotPasswordDataResponse;

  VerifyForgotPasswordResponse(this.verifyForgotPasswordDataResponse);

  factory VerifyForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class RegisterErrorResponse {
  @JsonKey(name: "phone")
  List<String>? phone;

  RegisterErrorResponse(this.phone);

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterErrorResponseToJson(this);
}

@JsonSerializable()
class RegisterResponse extends BaseResponse {
  @JsonKey(name: "errors")
  RegisterErrorResponse? registerErrorResponse;

  RegisterResponse(this.registerErrorResponse);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

/// TODO Use same class of RegisterResponse
@JsonSerializable()
class RequestSiteSurveyErrorResponse {
  @JsonKey(name: "project_type")
  List<String>? projectType;

  RequestSiteSurveyErrorResponse(this.projectType);

  factory RequestSiteSurveyErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestSiteSurveyErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSiteSurveyErrorResponseToJson(this);
}

@JsonSerializable()
class RequestSiteSurveyResponse extends BaseResponse {
  @JsonKey(name: "errors")
  RequestSiteSurveyErrorResponse? requestSiteSurveyErrorResponse;
  RequestSiteSurveyResponse(this.requestSiteSurveyErrorResponse);
  factory RequestSiteSurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestSiteSurveyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RequestSiteSurveyResponseToJson(this);
}
