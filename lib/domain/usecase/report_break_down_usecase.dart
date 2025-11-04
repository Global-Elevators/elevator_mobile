import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/report_break_down_request.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:elevator/domain/usecase/base_usecase.dart';

class ReportBreakDownUsecase implements BaseUseCase<ReportBreakDownRequest, void> {
  final Repository _repository;

  ReportBreakDownUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ReportBreakDownRequest input) async {
    return await _repository.reportBreakDown(input);
  }
}
