import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/domain/models/verify_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class VerifyUseCase implements BaseUseCase<VerifyUseCaseInput, VerifyModel> {
  final Repository _repository;

  VerifyUseCase(this._repository);

  @override
  Future<Either<Failure, VerifyModel>> execute(VerifyUseCaseInput input) async {
    return await _repository.verify(VerifyRequest(input.phone, input.code));
  }
}

class VerifyUseCaseInput {
  String phone, code;

  VerifyUseCaseInput(this.phone, this.code);
}
