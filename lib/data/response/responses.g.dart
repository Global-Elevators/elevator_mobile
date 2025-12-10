// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
        json['data'] == null
            ? null
            : CustomerDataResponse.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.customerDataResponse,
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

VerifyForgotPasswordDataResponse _$VerifyForgotPasswordDataResponseFromJson(
  Map<String, dynamic> json,
) => VerifyForgotPasswordDataResponse(
  json['token'] as String?,
  (json['expires_in'] as num?)?.toInt(),
);

Map<String, dynamic> _$VerifyForgotPasswordDataResponseToJson(
  VerifyForgotPasswordDataResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'expires_in': instance.expiresIn,
};

VerifyForgotPasswordResponse _$VerifyForgotPasswordResponseFromJson(
  Map<String, dynamic> json,
) =>
    VerifyForgotPasswordResponse(
        json['data'] == null
            ? null
            : VerifyForgotPasswordDataResponse.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VerifyForgotPasswordResponseToJson(
  VerifyForgotPasswordResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.verifyForgotPasswordDataResponse,
};

RegisterErrorResponse _$RegisterErrorResponseFromJson(
  Map<String, dynamic> json,
) => RegisterErrorResponse(
  (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$RegisterErrorResponseToJson(
  RegisterErrorResponse instance,
) => <String, dynamic>{'phone': instance.phone};

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
        json['errors'] == null
            ? null
            : RegisterErrorResponse.fromJson(
                json['errors'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'errors': instance.registerErrorResponse,
    };

RequestSiteSurveyResponse _$RequestSiteSurveyResponseFromJson(
  Map<String, dynamic> json,
) =>
    RequestSiteSurveyResponse(
        json['errors'] == null
            ? null
            : RequestSiteSurveyErrorResponse.fromJson(
                json['errors'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RequestSiteSurveyResponseToJson(
  RequestSiteSurveyResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'errors': instance.requestSiteSurveyErrorResponse,
};

UploadMediaResponse _$UploadMediaResponseFromJson(Map<String, dynamic> json) =>
    UploadMediaResponse(
        json['data'] == null
            ? null
            : UploadedMediaData.fromJson(json['data'] as Map<String, dynamic>),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$UploadMediaResponseToJson(
  UploadMediaResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

UploadedMediaData _$UploadedMediaDataFromJson(Map<String, dynamic> json) =>
    UploadedMediaData(
      (json['uploads'] as List<dynamic>?)
          ?.map((e) => UploadedMedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UploadedMediaDataToJson(UploadedMediaData instance) =>
    <String, dynamic>{'uploads': instance.uploads};

UploadedMedia _$UploadedMediaFromJson(Map<String, dynamic> json) =>
    UploadedMedia(json['media_uuid'] as String?, json['url'] as String?);

Map<String, dynamic> _$UploadedMediaToJson(UploadedMedia instance) =>
    <String, dynamic>{'media_uuid': instance.id, 'url': instance.url};

UserProfileDataResponse _$UserProfileDataResponseFromJson(
  Map<String, dynamic> json,
) => UserProfileDataResponse(
  json['sir_name'] as String?,
  json['last_name'] as String?,
);

Map<String, dynamic> _$UserProfileDataResponseToJson(
  UserProfileDataResponse instance,
) => <String, dynamic>{
  'sir_name': instance.sirName,
  'last_name': instance.lastName,
};

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['address'] as String?,
      json['birthdate'] as String?,
      json['profile_data'] == null
          ? null
          : UserProfileDataResponse.fromJson(
              json['profile_data'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'birthdate': instance.birthdate,
      'profile_data': instance.profileData,
    };

GetUserResponse _$GetUserResponseFromJson(Map<String, dynamic> json) =>
    GetUserResponse(
        json['data'] == null
            ? null
            : UserDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetUserResponseToJson(GetUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.userDataResponse,
    };

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) =>
    NotificationsResponse(
        (json['data'] as List<dynamic>?)
            ?.map(
              (e) =>
                  NotificationDataResponse.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.notificationDataResponse,
};

NotificationDataResponse _$NotificationDataResponseFromJson(
  Map<String, dynamic> json,
) => NotificationDataResponse(
  json['id'] as String?,
  json['type'] as String?,
  json['title'] as String?,
  json['body'] as String?,
);

Map<String, dynamic> _$NotificationDataResponseToJson(
  NotificationDataResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'title': instance.title,
  'body': instance.body,
};

NextAppointmentResponse _$NextAppointmentResponseFromJson(
  Map<String, dynamic> json,
) =>
    NextAppointmentResponse(
        json['data'] == null
            ? null
            : NextAppointmentDataResponse.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$NextAppointmentResponseToJson(
  NextAppointmentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.nextAppointmentDataResponse,
};

NextAppointmentDataResponse _$NextAppointmentDataResponseFromJson(
  Map<String, dynamic> json,
) => NextAppointmentDataResponse(
  json['contract_id'] as int?,
  json['site_survey_id'] as int?,
  json['project_address'] as String?,
  json['schedule_date'] as String?,
  json['days_left'] as String?,
  json['contract_status'] as String?,
);

Map<String, dynamic> _$NextAppointmentDataResponseToJson(
  NextAppointmentDataResponse instance,
) => <String, dynamic>{
  'contract_id': instance.id,
  'site_survey_id': instance.siteSurveyId,
  'project_address': instance.projectAddress,
  'schedule_date': instance.scheduleDate,
  'days_left': instance.daysLeft,
  'contract_status': instance.contractStatus,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

LibraryResponse _$LibraryResponseFromJson(Map<String, dynamic> json) =>
    LibraryResponse(
        data:
            (json['data'] as List<dynamic>?)
                ?.map((e) => DatumResponse.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LibraryResponseToJson(LibraryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

DatumResponse _$DatumFromJson(Map<String, dynamic> json) => DatumResponse(
  type: json['type'] as String? ?? '',
  typeLabel: json['type_label'] as String? ?? '',
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$DatumToJson(DatumResponse instance) => <String, dynamic>{
  'type': instance.type,
  'type_label': instance.typeLabel,
  'attachments': instance.attachments.map((e) => e.toJson()).toList(),
};

AttachmentResponse _$AttachmentFromJson(Map<String, dynamic> json) =>
    AttachmentResponse(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );

Map<String, dynamic> _$AttachmentToJson(AttachmentResponse instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};

ContractsStatusResponse _$ContractsStatusResponseFromJson(
  Map<String, dynamic> json,
) =>
    ContractsStatusResponse(
        data:
            (json['data'] as List<dynamic>?)
                ?.map(
                  (e) => ContractsStatusDataResponse.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList() ??
            [],
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ContractsStatusResponseToJson(
  ContractsStatusResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

ContractsStatusDataResponse _$ContractsStatusDataResponseFromJson(
  Map<String, dynamic> json,
) => ContractsStatusDataResponse(
  id: (json['id'] as num).toInt(),
  status: Status.fromJson(json['status'] as Map<String, dynamic>),
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: DateTime.parse(json['end_date'] as String),
  timeline: Timeline.fromJson(json['timeline'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContractsStatusDataResponseToJson(
  ContractsStatusDataResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status.toJson(),
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate.toIso8601String(),
  'timeline': instance.timeline.toJson(),
};

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  value: json['value'] as String,
  label: json['label'] as String,
  color: json['color'] as String,
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'value': instance.value,
  'label': instance.label,
  'color': instance.color,
};

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
  scopeLabel: json['scope_label'] as String,
  currentStatusLabel: json['current_status_label'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => Item.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
  'scope_label': instance.scopeLabel,
  'current_status_label': instance.currentStatusLabel,
  'items': instance.items.map((e) => e.toJson()).toList(),
};

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  value: json['value'] as String,
  label: json['label'] as String,
  icon: json['icon'] as String,
  color: json['color'] as String,
  state: json['state'] as String,
  deadline: DateTime.parse(json['deadline'] as String),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'value': instance.value,
  'label': instance.label,
  'icon': instance.icon,
  'color': instance.color,
  'state': instance.state,
  'deadline': instance.deadline.toIso8601String(),
};

RequestStatusResponse _$RequestStatusResponseFromJson(
  Map<String, dynamic> json,
) =>
    RequestStatusResponse(
        data:
            (json['data'] as List<dynamic>?)
                ?.map(
                  (e) => RequestStatusDataResponse.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList() ??
            [],
      )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RequestStatusResponseToJson(
  RequestStatusResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data.map((e) => e.toJson()).toList(),
};

RequestStatusDataResponse _$RequestStatusDataResponseFromJson(
  Map<String, dynamic> json,
) => RequestStatusDataResponse(
  id: json['id'] as int,
  label: json['label'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$RequestStatusDataResponseToJson(
  RequestStatusDataResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
};
