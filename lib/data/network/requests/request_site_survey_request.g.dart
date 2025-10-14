// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_site_survey_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSiteSurveyRequest _$RequestSiteSurveyRequestFromJson(
  Map<String, dynamic> json,
) => RequestSiteSurveyRequest(
  userInfo: UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
  scopeOfWork: json['scope_of_work'] as String,
  projectAddress: json['project_address'] as String,
  projectType: json['project_type'] as String,
  scheduleDate: json['schedule_date'] as String,
  notes: json['notes'] as String,
  extraData: ExtraData.fromJson(json['extra_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RequestSiteSurveyRequestToJson(
  RequestSiteSurveyRequest instance,
) => <String, dynamic>{
  'user_info': instance.userInfo.toJson(),
  'scope_of_work': instance.scopeOfWork,
  'project_address': instance.projectAddress,
  'project_type': instance.projectType,
  'schedule_date': instance.scheduleDate,
  'notes': instance.notes,
  'extra_data': instance.extraData.toJson(),
};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
  fullName: json['full_name'] as String,
  sirName: json['sirname'] as String,
  middleName: json['middle_name'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  company: json['company'] as String,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'full_name': instance.fullName,
  'sirname': instance.sirName,
  'middle_name': instance.middleName,
  'phone': instance.phone,
  'email': instance.email,
  'company': instance.company,
};

ExtraData _$ExtraDataFromJson(Map<String, dynamic> json) => ExtraData(
  shaftType: json['shaft_type'] as String,
  shaftLocation: json['shaft_location'] as String,
  shaftDimensions: ShaftDimensions.fromJson(
    json['shaft_dimensions'] as Map<String, dynamic>,
  ),
  pitDepth: (json['pit_depth'] as num).toInt(),
  lastFloorHeight: (json['last_floor_height'] as num).toInt(),
  machineRoom: json['machine_room'] as bool,
  height: (json['height'] as num).toInt(),
  stops: (json['stops'] as num).toInt(),
  underWarrantyOrContract: json['under_warranty_or_contract'] as bool,
  elevatorBrand: json['elevator_brand'] as String,
  elevatorType: json['elevator_type'] as String,
  descriptionOfBreakdown: json['description_of_breakdown'] as String,
  photosOrVideos: (json['photos_or_videos'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ExtraDataToJson(ExtraData instance) => <String, dynamic>{
  'shaft_type': instance.shaftType,
  'shaft_location': instance.shaftLocation,
  'shaft_dimensions': instance.shaftDimensions,
  'pit_depth': instance.pitDepth,
  'last_floor_height': instance.lastFloorHeight,
  'machine_room': instance.machineRoom,
  'height': instance.height,
  'stops': instance.stops,
  'under_warranty_or_contract': instance.underWarrantyOrContract,
  'elevator_brand': instance.elevatorBrand,
  'elevator_type': instance.elevatorType,
  'description_of_breakdown': instance.descriptionOfBreakdown,
  'photos_or_videos': instance.photosOrVideos,
};

ShaftDimensions _$ShaftDimensionsFromJson(Map<String, dynamic> json) =>
    ShaftDimensions(
      width: (json['width'] as num).toInt(),
      depth: (json['depth'] as num).toInt(),
    );

Map<String, dynamic> _$ShaftDimensionsToJson(ShaftDimensions instance) =>
    <String, dynamic>{'width': instance.width, 'depth': instance.depth};
