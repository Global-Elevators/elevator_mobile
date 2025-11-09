// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_commercial_offers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TechnicalCommercialOffersRequest _$TechnicalCommercialOffersFromJson(
    Map<String, dynamic> json,
    ) => TechnicalCommercialOffersRequest(
  userInfo: UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
  scopeOfWork: json['scope_of_work'] as String,
  projectAddress: json['project_address'] as String,
  projectType: json['project_type'] as String,
  scheduleDate: json['schedule_date'] as String,
  notes: json['notes'] as String,
  extraData: ExtraData.fromJson(json['extra_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TechnicalCommercialOffersToJson(
    TechnicalCommercialOffersRequest instance,
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
  mapLocation: MapLocation.fromJson(
    json['map_location'] as Map<String, dynamic>,
  ),
  shaftType: json['shaft_type'] as String,
  shaftLocation: json['shaft_location'] as String,
  shaftDimensions: ShaftDimensions.fromJson(
    json['shaft_dimensions'] as Map<String, dynamic>,
  ),
  pitDepth: (json['pit_depth'] as num).toDouble(),
  machineRoom: json['machine_room'] as bool,
  height: (json['height'] as num).toDouble(),
  stops: (json['stops'] as num).toInt(),
  lastFloorHeight: (json['last_floor_height'] as num).toDouble(),
  requiredDoorWidth: (json['required_door_width'] as num).toDouble(),
  photosOrVideos: (json['photos_or_videos'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ExtraDataToJson(ExtraData instance) => <String, dynamic>{
  'map_location': instance.mapLocation.toJson(),
  'shaft_type': instance.shaftType,
  'shaft_location': instance.shaftLocation,
  'shaft_dimensions': instance.shaftDimensions.toJson(),
  'pit_depth': instance.pitDepth,
  'machine_room': instance.machineRoom,
  'height': instance.height,
  'stops': instance.stops,
  'last_floor_height': instance.lastFloorHeight,
  'required_door_width': instance.requiredDoorWidth,
  'photos_or_videos': instance.photosOrVideos,
};

ShaftDimensions _$ShaftDimensionsFromJson(Map<String, dynamic> json) =>
    ShaftDimensions(
      width: (json['width'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );

Map<String, dynamic> _$ShaftDimensionsToJson(ShaftDimensions instance) =>
    <String, dynamic>{'width': instance.width, 'depth': instance.depth};

MapLocation _$MapLocationFromJson(Map<String, dynamic> json) => MapLocation(
  latitude: (json['lat'] as num).toDouble(),
  longitude: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$MapLocationToJson(MapLocation instance) =>
    <String, dynamic>{'lat': instance.latitude, 'lng': instance.longitude};