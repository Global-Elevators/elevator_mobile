import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/notifications_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class NotificationUsecase extends BaseUseCase<void, NotificationsModel> {
  final Repository _repository;

  NotificationUsecase(this._repository);

  @override
  Future<Either<Failure, NotificationsModel>> execute(void input) async {
    return await _repository.getNotifications();
  }
}
