import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class LogoutUsecase extends BaseUseCase<void, void> {
  final Repository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(void input) async {
    return await _repository.logout();
  }
}

