// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_break_down_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportBreakDownRequest _$ReportBreakDownRequestFromJson(
  Map<String, dynamic> json,
) => ReportBreakDownRequest(
  notes: json['notes'] as String,
  photosOrVideos: (json['photos_or_videos'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ReportBreakDownRequestToJson(
  ReportBreakDownRequest instance,
) => <String, dynamic>{
  'notes': instance.notes,
  'photos_or_videos': instance.photosOrVideos,
};
