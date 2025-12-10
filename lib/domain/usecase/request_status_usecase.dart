import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/request_status_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class RequestStatusUsecase implements BaseUseCase<void, RequestStatusModel> {
  final Repository _repository;

  RequestStatusUsecase(this._repository);

  @override
  Future<Either<Failure, RequestStatusModel>> execute(void input) async {
    return await _repository.getRequestStatus();
  }
}
