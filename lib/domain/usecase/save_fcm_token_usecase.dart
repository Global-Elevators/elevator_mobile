import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class SaveFcmTokenUsecase extends BaseUseCase<String, void> {
  final Repository _repository;

  SaveFcmTokenUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String token) async {
    return await _repository.saveFcmToken(token);
  }
}

