import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

/// TODO Make on error response class for each response

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

@JsonSerializable()
class RequestSiteSurveyErrorResponse {
  final List<String>? errors;

  RequestSiteSurveyErrorResponse(this.errors);

  factory RequestSiteSurveyErrorResponse.fromJson(Map<String, dynamic> json) {
    final List<String> mergedErrors = [];

    json.forEach((key, value) {
      if (value is List) {
        mergedErrors.addAll(value.map((e) => e.toString()));
      }
    });

    return RequestSiteSurveyErrorResponse(
      mergedErrors.isEmpty ? null : mergedErrors,
    );
  }

  Map<String, dynamic> toJson() => {"errors": errors};
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

@JsonSerializable()
class UploadMediaResponse extends BaseResponse {
  @JsonKey(name: "data")
  final UploadedMediaData? data;

  UploadMediaResponse(this.data);

  factory UploadMediaResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadMediaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadMediaResponseToJson(this);
}

@JsonSerializable()
class UploadedMediaData {
  @JsonKey(name: "uploads")
  final List<UploadedMedia>? uploads;

  UploadedMediaData(this.uploads);

  factory UploadedMediaData.fromJson(Map<String, dynamic> json) =>
      _$UploadedMediaDataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedMediaDataToJson(this);
}

@JsonSerializable()
class UploadedMedia {
  @JsonKey(name: "media_uuid")
  final String? id;

  @JsonKey(name: "url")
  final String? url;

  UploadedMedia(this.id, this.url);

  factory UploadedMedia.fromJson(Map<String, dynamic> json) =>
      _$UploadedMediaFromJson(json);

  Map<String, dynamic> toJson() => _$UploadedMediaToJson(this);
}

@JsonSerializable()
class UserProfileDataResponse {
  @JsonKey(name: "sir_name")
  String? sirName;
  @JsonKey(name: "last_name")
  String? lastName;

  UserProfileDataResponse(this.sirName, this.lastName);

  factory UserProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataResponseToJson(this);
}

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "birthdate")
  String? birthdate;
  @JsonKey(name: "profile_data")
  UserProfileDataResponse? profileData;

  UserDataResponse(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.birthdate,
    this.profileData,
  );

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class GetUserResponse extends BaseResponse {
  @JsonKey(name: "data")
  UserDataResponse? userDataResponse;

  GetUserResponse(this.userDataResponse);

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserResponseToJson(this);
}

@JsonSerializable()
class NotificationsResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<NotificationDataResponse>? notificationDataResponse;

  NotificationsResponse(this.notificationDataResponse);

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}

@JsonSerializable()
class NotificationDataResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "body")
  String? body;

  NotificationDataResponse(this.id, this.type, this.title, this.body);

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataResponseToJson(this);
}

@JsonSerializable()
class NextAppointmentResponse extends BaseResponse {
  @JsonKey(name: "data")
  NextAppointmentDataResponse? nextAppointmentDataResponse;

  NextAppointmentResponse(this.nextAppointmentDataResponse);

  factory NextAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$NextAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NextAppointmentResponseToJson(this);
}

@JsonSerializable()
class NextAppointmentDataResponse {
  @JsonKey(name: "contract_id")
  int? id;
  @JsonKey(name: "site_survey_id")
  int? siteSurveyId;
  @JsonKey(name: "project_address")
  String? projectAddress;
  @JsonKey(name: "schedule_date")
  String? scheduleDate;
  @JsonKey(name: "days_left")
  String? daysLeft;
  @JsonKey(name: "contract_status")
  String? contractStatus;

  NextAppointmentDataResponse(
    this.id,
    this.siteSurveyId,
    this.projectAddress,
    this.scheduleDate,
    this.daysLeft,
    this.contractStatus,
  );

  factory NextAppointmentDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NextAppointmentDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NextAppointmentDataResponseToJson(this);
}

@JsonSerializable()
class LibraryResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<DatumResponse> data;

  LibraryResponse({
    required this.data,
  });

  factory LibraryResponse.fromJson(Map<String, dynamic> json) =>
      _$LibraryResponseFromJson
    (json);

  Map<String, dynamic> toJson() => _$LibraryResponseToJson(this);
}

@JsonSerializable()
class DatumResponse {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "type_label")
  String typeLabel;
  @JsonKey(name: "attachments")
  List<AttachmentResponse> attachments;

  DatumResponse({
    required this.type,
    required this.typeLabel,
    required this.attachments,
  });

  factory DatumResponse.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class AttachmentResponse {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "url")
  String url;

  AttachmentResponse({
    required this.name,
    required this.url,
  });

  factory AttachmentResponse.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
