import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class DeleteNotificationUsecase extends BaseUseCase<String, void> {
  final Repository _repository;

  DeleteNotificationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String id) async {
    return await _repository.deleteNotification(id);
  }
}
