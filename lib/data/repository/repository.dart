import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/mappers/authentication_mapper.dart';
import 'package:elevator/data/mappers/register_mapper.dart';
import 'package:elevator/data/mappers/request_site_survey_mapper.dart';
import 'package:elevator/data/mappers/upload_media_mapper.dart';
import 'package:elevator/data/mappers/verify_forgot_password_mapper.dart';
import 'package:elevator/data/mappers/verify_mapper.dart';
import 'package:elevator/data/network/exception_handler.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/network_info.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/models/upload_media_model.dart';
import 'package:elevator/domain/models/verify_forgot_password_model.dart';
import 'package:elevator/domain/models/verify_model.dart';
import 'package:elevator/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  Future<bool> hasNetworkConnection() async => await _networkInfo.isConnected;

  // ---------------- LOGIN ----------------
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await hasNetworkConnection()) {
      return _performLogin(loginRequest);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

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
      LoginResponse response,
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

  // ---------------- VERIFY ----------------
  @override
  Future<Either<Failure, VerifyModel>> verify(VerifyRequest verifyRequests) async {
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

  // ---------------- FORGOT PASSWORD ----------------
  @override
  Future<Either<Failure, Authentication>> forgotPassword(String phone) async {
    if (await hasNetworkConnection()) {
      return _performForgotPassword(phone);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, Authentication>> _performForgotPassword(
      String phone,
      ) async {
    try {
      final response = await _remoteDataSource.forgotPassword(phone);
      return _mapForgotPasswordResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, Authentication> _mapForgotPasswordResponseToResult(
      LoginResponse response,
      ) {
    return _isSuccessfulResponse(response)
        ? Right(response.toDomain())
        : Left(_mapFailureFromResponse(response));
  }

  // ---------------- VERIFY FORGOT PASSWORD ----------------
  @override
  Future<Either<Failure, VerifyForgotPasswordModel>> verifyForgotPassword(
      VerifyRequest verifyForgotPasswordRequest,
      ) async {
    if (await hasNetworkConnection()) {
      return _performVerifyForgotPassword(verifyForgotPasswordRequest);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, VerifyForgotPasswordModel>>
  _performVerifyForgotPassword(
      VerifyRequest verifyForgotPasswordRequest,
      ) async {
    try {
      final response = await _remoteDataSource.verifyForgotPassword(
        verifyForgotPasswordRequest,
      );
      return _mapVerifyForgotPasswordResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, VerifyForgotPasswordModel>
  _mapVerifyForgotPasswordResponseToResult(
      VerifyForgotPasswordResponse response,
      ) {
    return _isSuccessfulResponse(response)
        ? Right(response.toDomain())
        : Left(_mapFailureFromResponse(response));
  }

  // ---------------- RESET PASSWORD ----------------
  @override
  Future<Either<Failure, void>> resetPassword(
      ResetPasswordRequest resetPasswordRequest,
      ) async {
    if (await hasNetworkConnection()) {
      return _performResetPassword(resetPasswordRequest);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, void>> _performResetPassword(
      ResetPasswordRequest resetPasswordRequest,
      ) async {
    try {
      await _remoteDataSource.resetPassword(resetPasswordRequest);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- RESEND OTP ----------------
  @override
  Future<Either<Failure, void>> resendOtp(String phone) async {
    if (await hasNetworkConnection()) {
      return _performResendOtp(phone);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, void>> _performResendOtp(String phone) async {
    try {
      await _remoteDataSource.resendOtp(phone);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- REGISTER ----------------
  @override
  Future<Either<Failure, void>> register(UserData userData) async {
    if (await hasNetworkConnection()) {
      return _performRegister(userData);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, void>> _performRegister(UserData userData) async {
    try {
      final response = await _remoteDataSource.register(userData);
      return _mapRegisterResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, void> _mapRegisterResponseToResult(
      RegisterResponse response,
      ) =>
      _isSuccessfulResponse(response)
          ? const Right(null)
          : Left(_mapFailureFromRegisterResponse(response.toDomain()));

  Failure _mapFailureFromRegisterResponse(String response) {
    return Failure(ApiInternalStatus.failure, response);
  }

  // ---------------- REQUEST SITE SURVEY ----------------
  @override
  Future<Either<Failure, void>> requestSiteSurvey(
      RequestSiteSurveyRequest request,
      ) async {
    if (await hasNetworkConnection()) {
      return _performRequestSiteSurvey(request);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, void>> _performRequestSiteSurvey(
      RequestSiteSurveyRequest request,
      ) async {
    try {
      final response = await _remoteDataSource.requestSiteSurvey(request);
      return _mapRequestSiteSurveyResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, void> _mapRequestSiteSurveyResponseToResult(
      RequestSiteSurveyResponse response,
      ) =>
      _isSuccessfulResponse(response)
          ? const Right(null)
          : Left(_mapFailureFromRequestSiteSurveyResponse(response.toDomain()));

  Failure _mapFailureFromRequestSiteSurveyResponse(String response) {
    return Failure(ApiInternalStatus.failure, response);
  }

  // ---------------- UPLOAD MEDIA ----------------
  @override
  Future<Either<Failure, UploadMediaModel>> uploadMedia(
      List<MultipartFile> files,
      ) async {
    if (await hasNetworkConnection()) {
      return _performUploadMedia(files);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, UploadMediaModel>> _performUploadMedia(
      List<MultipartFile> files,
      ) async {
    try {
      final response = await _remoteDataSource.uploadMedia(files);
      return _mapUploadMediaResponseToResult(response);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  Either<Failure, UploadMediaModel> _mapUploadMediaResponseToResult(
      UploadMediaResponse response,
      ) {
    return _isSuccessfulResponse(response)
        ? Right(response.toDomain())
        : Left(_mapFailureFromUploadMediaResponse(response.message));
  }

  Failure _mapFailureFromUploadMediaResponse(String? message) {
    return Failure(
      ApiInternalStatus.failure,
      message ?? ResponseMessage.defaultError,
    );
  }

}
