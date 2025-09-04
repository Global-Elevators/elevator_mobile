import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/mappers/authentication_mapper.dart';
import 'package:elevator/data/network/exception_handler.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/network_info.dart';
import 'package:elevator/data/network/requests.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/register_model.dart';
import 'package:elevator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> register(
    RegisterRequests registerRequest,
  ) async {
    if (await isConnected()) {
      return await _handleRegisterRequest(registerRequest);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<bool> isConnected() async => await _networkInfo.isConnected;

  Future<Either<Failure, Authentication>> _handleRegisterRequest(
    RegisterRequests registerRequests,
  ) async {
    try {
      final AuthenticationResponse response = await _remoteDataSource.register(
        registerRequests,
      );
      return _processRegisterResponse(response);
    } catch (error) {
      return Left(ExceptionHandler.handel(error).failure);
    }
  }

  Either<Failure, Authentication> _processRegisterResponse(
    AuthenticationResponse response,
  ) {
    if (isSuccessfulAuthentication(response)) {
      return Right(response.toDomain());
    } else {
      return Left(_createFailureFromAuthenticationResponse(response));
    }
  }

  bool isSuccessfulAuthentication(AuthenticationResponse response) =>
      response.status == ApiInternalStatus.success;

  Failure _createFailureFromAuthenticationResponse(
    AuthenticationResponse response,
  ) {
    return Failure(
      ApiInternalStatus.failure,
      response.message ?? ResponseMessage.defaultError,
    );
  }

  @override
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequest) {
    // TODO: implement login
    throw UnimplementedError();
  }
}