// user data use case
import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';
import '../models/user_data_model.dart';

class UserDataUsecase implements BaseUseCase<void, GetUserInfo> {
  final Repository _repository;

  UserDataUsecase(this._repository);


  @override
  Future<Either<Failure, GetUserInfo>> execute(void input) async {
    return await _repository.getUserData();
  }
}
