import 'package:json_annotation/json_annotation.dart';

part 'technical_commercial_offers_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TechnicalCommercialOffersRequest {
  @JsonKey(name: 'user_info')
  final UserInfo userInfo;

  @JsonKey(name: 'scope_of_work')
  final String scopeOfWork;

  @JsonKey(name: 'project_address')
  final String projectAddress;

  @JsonKey(name: 'project_type')
  final String projectType;

  @JsonKey(name: 'schedule_date')
  final String scheduleDate;

  @JsonKey(name: 'notes')
  final String notes;

  @JsonKey(name: 'extra_data')
  final ExtraData extraData;

  TechnicalCommercialOffersRequest({
    required this.userInfo,
    required this.scopeOfWork,
    required this.projectAddress,
    required this.projectType,
    required this.scheduleDate,
    required this.notes,
    required this.extraData,
  });

  factory TechnicalCommercialOffersRequest.fromJson(Map<String, dynamic> json) =>
      _$TechnicalCommercialOffersFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicalCommercialOffersToJson(this);
}

@JsonSerializable()
class UserInfo {
  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'sirname')
  final String sirName;

  @JsonKey(name: 'middle_name')
  final String middleName;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'company')
  final String company;

  UserInfo({
    required this.fullName,
    required this.sirName,
    required this.middleName,
    required this.phone,
    required this.email,
    required this.company,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExtraData {
  @JsonKey(name: 'map_location')
  final MapLocation mapLocation;

  @JsonKey(name: 'shaft_type')
  final String shaftType;

  @JsonKey(name: 'shaft_location')
  final String shaftLocation;

  @JsonKey(name: 'shaft_dimensions')
  final ShaftDimensions shaftDimensions;

  @JsonKey(name: 'pit_depth')
  final double pitDepth;

  @JsonKey(name: 'machine_room')
  final bool machineRoom;

  @JsonKey(name: 'height')
  final double height;

  @JsonKey(name: 'stops')
  final int stops;

  @JsonKey(name: 'last_floor_height')
  final double lastFloorHeight;

  @JsonKey(name: 'required_door_width')
  final double requiredDoorWidth;

  @JsonKey(name: 'photos_or_videos')
  final List<String> photosOrVideos;

  ExtraData({
    required this.mapLocation,
    required this.shaftType,
    required this.shaftLocation,
    required this.shaftDimensions,
    required this.pitDepth,
    required this.machineRoom,
    required this.height,
    required this.stops,
    required this.lastFloorHeight,
    required this.requiredDoorWidth,
    required this.photosOrVideos,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      _$ExtraDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraDataToJson(this);
}

@JsonSerializable()
class ShaftDimensions {
  @JsonKey(name: 'width')
  final double width;

  @JsonKey(name: 'depth')
  final double depth;

  ShaftDimensions({
    required this.width,
    required this.depth,
  });

  factory ShaftDimensions.fromJson(Map<String, dynamic> json) =>
      _$ShaftDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ShaftDimensionsToJson(this);
}

@JsonSerializable()
class MapLocation {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lng')
  final double longitude;

  MapLocation({
    required this.latitude,
    required this.longitude,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) =>
      _$MapLocationFromJson(json);

  Map<String, dynamic> toJson() => _$MapLocationToJson(this);
}


