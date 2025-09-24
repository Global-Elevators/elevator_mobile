import 'package:dartz/dartz.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/models/verify_model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, VerifyModel>> verify(VerifyRequest verifyRequests);
}