import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/contracts_status_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class ContractsStatusUsecase
    implements BaseUseCase<void, ContractsStatusModel> {
  final Repository _repository;

  ContractsStatusUsecase(this._repository);

  @override
  Future<Either<Failure, ContractsStatusModel>> execute(void input) async {
    return await _repository.getContractsStatus();
  }
}
