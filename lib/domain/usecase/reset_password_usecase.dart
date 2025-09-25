import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class ResetPasswordUsecase
    extends BaseUseCase<ResetPasswordUseCaseInput, void> {
  final Repository _repository;

  ResetPasswordUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ResetPasswordUseCaseInput input) {
    return _repository.resetPassword(
      ResetPasswordRequest(
        input.token,
        input.password,
        input.passwordConfirmation,
      ),
    );
  }
}

class ResetPasswordUseCaseInput {
  final String token;
  final String password;
  final String passwordConfirmation;

  ResetPasswordUseCaseInput(
    this.token,
    this.password,
    this.passwordConfirmation,
  );
}
