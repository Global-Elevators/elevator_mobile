import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import '../repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';
import 'package:elevator/data/network/requests/change_password_request.dart';

class ChangePasswordUsecase implements BaseUseCase<ChangePasswordUsecaseInput, void> {
  final Repository _repository;

  ChangePasswordUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ChangePasswordUsecaseInput input) {
    return _repository.changePassword(
      ChangePasswordRequest(
        input.oldPassword,
        input.newPassword,
        input.newPasswordConfirmation,
      ),
    );
  }
}

class ChangePasswordUsecaseInput {
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  ChangePasswordUsecaseInput(this.oldPassword, this.newPassword, this.newPasswordConfirmation);
}
