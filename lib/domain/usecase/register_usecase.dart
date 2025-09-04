import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests.dart';
import 'package:elevator/domain/models/register_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
    RegisterUseCaseInput registerRequests,
  ) async {
    return await _repository.register(
      RegisterRequests(
        registerRequests.name,
        registerRequests.phone,
        registerRequests.email,
        registerRequests.password,
        registerRequests.profilePicture,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String name;
  String phone;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(
    this.name,
    this.phone,
    this.email,
    this.password,
    this.profilePicture,
  );
}
