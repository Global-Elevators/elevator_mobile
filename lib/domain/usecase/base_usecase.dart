import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  // Future<Either<dynamic, Out>> execute(In input);
  Future<Either<Failure, Out>> execute(In input);
/// TODO: Change dynamic to Failure above and fix issues of return phone message in register repo implementation
}