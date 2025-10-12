import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';

extension RequestSiteSurveyMapper on RequestSiteSurveyResponse? {
  String toDomain() {
    return this?.requestSiteSurveyErrorResponse!.projectType!.first.orEmpty() ??
        Constants.empty;
  }
}
