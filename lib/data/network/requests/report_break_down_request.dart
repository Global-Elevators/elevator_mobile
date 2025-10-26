import 'package:json_annotation/json_annotation.dart';
part 'report_break_down_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ReportBreakDownRequest {
  @JsonKey(name: 'notes')
  final String notes;
  @JsonKey(name: 'photos_or_videos')
  final List<String> photosOrVideos;

  ReportBreakDownRequest({
    required this.notes,
    required this.photosOrVideos,
  });

  factory ReportBreakDownRequest.fromJson(Map<String, dynamic> json) =>
      _$ReportBreakDownRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReportBreakDownRequestToJson(this);
}