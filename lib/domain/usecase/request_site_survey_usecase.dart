import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class RequestSiteSurveyUsecase
    implements BaseUseCase<RequestSiteSurveyRequest, void> {
  final Repository _repository;

  RequestSiteSurveyUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(
    RequestSiteSurveyRequest request,
  ) async {
    return await _repository.requestSiteSurvey(request);
  }
}
