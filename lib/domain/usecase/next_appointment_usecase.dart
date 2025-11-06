import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class NextAppointmentUsecase
    implements BaseUseCase<void, NextAppointmentModel> {
  final Repository _repository;

  NextAppointmentUsecase(this._repository);

  @override
  Future<Either<Failure, NextAppointmentModel>> execute(void input) async {
    return await _repository.nextAppointment();
  }
}
