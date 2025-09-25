import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, Authentication> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(String phone) async {
    return await _repository.forgotPassword(phone);
  }
}