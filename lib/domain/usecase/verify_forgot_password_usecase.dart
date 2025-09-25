import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/domain/models/verify_forgot_password_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class VerifyForgotPasswordUseCase
    implements
        BaseUseCase<
          VerifyForgotPasswordUseCaseInput,
          VerifyForgotPasswordModel
        > {
  final Repository _repository;

  VerifyForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, VerifyForgotPasswordModel>> execute(
    VerifyForgotPasswordUseCaseInput input,
  ) async {
    return await _repository.verifyForgotPassword(
      VerifyRequest(input.phone, input.code),
    );
  }
}

class VerifyForgotPasswordUseCaseInput {
  String phone, code;

  VerifyForgotPasswordUseCaseInput(this.phone, this.code);
}
