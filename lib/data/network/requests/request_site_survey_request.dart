import 'package:json_annotation/json_annotation.dart';
part 'request_site_survey_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RequestSiteSurveyRequest {
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

  RequestSiteSurveyRequest({
    required this.userInfo,
    required this.scopeOfWork,
    required this.projectAddress,
    required this.projectType,
    required this.scheduleDate,
    required this.notes,
    required this.extraData,
  });

  factory RequestSiteSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestSiteSurveyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestSiteSurveyRequestToJson(this);

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

@JsonSerializable()
class ExtraData {
  @JsonKey(name: 'shaft_type')
  final String shaftType;
  @JsonKey(name: 'shaft_location')
  final String shaftLocation;
  @JsonKey(name: 'shaft_dimensions')
  final ShaftDimensions shaftDimensions;
  @JsonKey(name: 'pit_depth')
  final int pitDepth;
  @JsonKey(name: 'last_floor_height')
  final int lastFloorHeight;
  @JsonKey(name: 'machine_room')
  final bool machineRoom;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'stops')
  final int stops;
  @JsonKey(name: 'under_warranty_or_contract')
  final bool underWarrantyOrContract;
  @JsonKey(name: 'elevator_brand')
  final String elevatorBrand;
  @JsonKey(name: 'elevator_type')
  final String elevatorType;
  @JsonKey(name: 'description_of_breakdown')
  final String descriptionOfBreakdown;
  @JsonKey(name: 'photos_or_videos')
  final List<String> photosOrVideos;

  ExtraData({
    required this.shaftType,
    required this.shaftLocation,
    required this.shaftDimensions,
    required this.pitDepth,
    required this.lastFloorHeight,
    required this.machineRoom,
    required this.height,
    required this.stops,
    required this.underWarrantyOrContract,
    required this.elevatorBrand,
    required this.elevatorType,
    required this.descriptionOfBreakdown,
    required this.photosOrVideos,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) =>
      _$ExtraDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraDataToJson(this);
}

@JsonSerializable()
class ShaftDimensions {
  @JsonKey(name: 'width')
  final int width;
  @JsonKey(name: 'depth')
  final int depth;

  ShaftDimensions({required this.width, required this.depth});

  factory ShaftDimensions.fromJson(Map<String, dynamic> json) =>
      _$ShaftDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$ShaftDimensionsToJson(this);
}
