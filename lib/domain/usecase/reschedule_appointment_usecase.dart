import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class RescheduleAppointmentUsecase implements BaseUseCase<String, void> {
  final Repository _repository;

  RescheduleAppointmentUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String input) async {
    return await _repository.rescheduleAppointment(input);
  }
}

