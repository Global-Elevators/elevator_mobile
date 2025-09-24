import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/mappers/authentication_mapper.dart';
import 'package:elevator/data/mappers/verify_mapper.dart';
import 'package:elevator/data/network/exception_handler.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/network_info.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/models/verify_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    if (await hasNetworkConnection()) {
      return _performLogin(loginRequest);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<bool> hasNetworkConnection() async => await _networkInfo.isConnected;

  Future<Either<Failure, Authentication>> _performLogin(
    LoginRequest loginRequest,
  ) async {
    try {
      final response = await _remoteDataSource.login(loginRequest);
      return _mapLoginResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, Authentication> _mapLoginResponseToResult(
    AuthenticationResponse response,
  ) {
    return _isSuccessfulResponse(response)
        ? Right(response.toDomain())
        : Left(_mapFailureFromResponse(response));
  }

  bool _isSuccessfulResponse(BaseResponse response) => response.success == true;

  Failure _mapFailureFromResponse(BaseResponse response) {
    return Failure(
      ApiInternalStatus.failure,
      response.message ?? ResponseMessage.defaultError,
    );
  }

  @override
  Future<Either<Failure, VerifyModel>> verify(
    VerifyRequest verifyRequests,
  ) async {
    if (await hasNetworkConnection()) {
      return _performVerify(verifyRequests);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, VerifyModel>> _performVerify(
    VerifyRequest verifyRequests,
  ) async {
    try {
      final response = await _remoteDataSource.verify(verifyRequests);
      return _mapVerifyResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, VerifyModel> _mapVerifyResponseToResult(
    VerifyResponse response,
  ) {
    return _isSuccessfulResponse(response)
        ? Right(response.toDomain())
        : Left(_mapFailureFromResponse(response));
  }
}
