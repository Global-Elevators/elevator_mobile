import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';

// It only returns the first string in the list of errors.
extension RequestSiteSurveyMapper on RequestSiteSurveyResponse? {
  String toDomain() {
    return this?.requestSiteSurveyErrorResponse!.errors!.first.orEmpty() ??
        Constants.empty;
  }
}
