import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class ResendOtpUseCase implements BaseUseCase<String, void> {
  final Repository _repository;

  ResendOtpUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String phone) async {
    return await _repository.resendOtp(phone);
  }
}
