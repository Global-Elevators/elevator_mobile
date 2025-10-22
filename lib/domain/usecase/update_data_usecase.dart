import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';
import 'package:elevator/data/network/requests/update_user_request.dart';

class UpdateDataUsecase implements BaseUseCase<UpdateUserRequest, void> {
  final Repository _repository;

  UpdateDataUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(UpdateUserRequest input) async {
    return await _repository.updateUser(input);
  }
}
