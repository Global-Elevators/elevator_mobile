import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequest(input.phone, input.password));
  }
}

class LoginUseCaseInput {
  String phone, password;
  LoginUseCaseInput(this.phone, this.password);
}
