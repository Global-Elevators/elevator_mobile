import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests.dart';
import 'package:elevator/domain/models/login_model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequest);
}
