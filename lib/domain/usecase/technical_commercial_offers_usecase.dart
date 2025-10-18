import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/technical_commercial_offers_request.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class TechnicalCommercialOffersUsecase implements BaseUseCase<TechnicalCommercialOffersRequest, void> {
  final Repository _repository;

  TechnicalCommercialOffersUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(
    TechnicalCommercialOffersRequest request,
  ) async {
    return await _repository.technicalCommercialOffers(request);
  }
}