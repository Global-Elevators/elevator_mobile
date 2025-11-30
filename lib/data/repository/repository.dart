import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elevator/data/data_source/local_data_source.dart';
import 'package:elevator/data/data_source/remote_data_source.dart';
import 'package:elevator/data/mappers/authentication_mapper.dart';
import 'package:elevator/data/mappers/library_mapper.dart';
import 'package:elevator/data/mappers/next_appointment_mapper.dart';
import 'package:elevator/data/mappers/notification_mapper.dart';
import 'package:elevator/data/mappers/upload_media_mapper.dart';
import 'package:elevator/data/mappers/user_data_mapper.dart';
import 'package:elevator/data/mappers/verify_forgot_password_mapper.dart';
import 'package:elevator/data/mappers/verify_mapper.dart';
import 'package:elevator/data/network/exception_handler.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/change_password_request.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/report_break_down_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/data/network/requests/technical_commercial_offers_request.dart'
    hide UserInfo;
import 'package:elevator/data/network/requests/update_user_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/library_model.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/domain/models/notifications_model.dart';
import 'package:elevator/domain/models/upload_media_model.dart';
import 'package:elevator/domain/models/user_data_model.dart';
import 'package:elevator/domain/models/verify_forgot_password_model.dart';
import 'package:elevator/domain/models/verify_model.dart';
import 'package:elevator/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSource, this._localDataSource);

  bool _isSuccessfulResponse(BaseResponse response) => response.success == true;

  Failure _mapFailureFromResponse(BaseResponse response) {
    return Failure(
      ApiInternalStatus.failure,
      response.message ?? ResponseMessage.defaultError,
    );
  }

  // ---------------- LOGIN ----------------
  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    try {
      final response = await _remoteDataSource.login(loginRequest);
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(_mapFailureFromResponse(response));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- VERIFY ----------------
  @override
  Future<Either<Failure, VerifyModel>> verify(
    VerifyRequest verifyRequests,
  ) async {
    try {
      final response = await _remoteDataSource.verify(verifyRequests);
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(_mapFailureFromResponse(response));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- FORGOT PASSWORD ----------------
  @override
  Future<Either<Failure, Authentication>> forgotPassword(String phone) async {
    try {
      final response = await _remoteDataSource.forgotPassword(phone);
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(_mapFailureFromResponse(response));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- VERIFY FORGOT PASSWORD ----------------
  @override
  Future<Either<Failure, VerifyForgotPasswordModel>> verifyForgotPassword(
    VerifyRequest verifyForgotPasswordRequest,
  ) async {
    try {
      final response = await _remoteDataSource.verifyForgotPassword(
        verifyForgotPasswordRequest,
      );
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(_mapFailureFromResponse(response));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- RESET PASSWORD ----------------
  @override
  Future<Either<Failure, void>> resetPassword(
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
    try {
      final response = await _remoteDataSource.register(userData);
      return response.success == true
          ? const Right(null)
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- REQUEST SITE SURVEY ----------------
  @override
  Future<Either<Failure, void>> requestSiteSurvey(
    RequestSiteSurveyRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.requestSiteSurvey(request);
      return response.success == true
          ? const Right(null)
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- UPLOAD MEDIA ----------------
  @override
  Future<Either<Failure, UploadMediaModel>> uploadMedia(
    List<MultipartFile> files,
  ) async {
    try {
      final response = await _remoteDataSource.uploadMedia(files);
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- TECHNICAL COMMERCIAL OFFERS ----------------
  @override
  Future<Either<Failure, void>> technicalCommercialOffers(
    TechnicalCommercialOffersRequest request,
  ) async {
    try {
      final response = await _remoteDataSource.technicalCommercialOffers(
        request,
      );
      return response.success == true
          ? const Right(null)
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- SOS ----------------
  @override
  Future<Either<Failure, void>> sos() async {
    try {
      await _remoteDataSource.sos();
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- GET USER DATA (WITH CACHE) ----------------
  @override
  Future<Either<Failure, GetUserInfo>> getUserData() async {
    try {
      // Try to get data from cache first
      final cachedResponse = await _localDataSource.getUserData();
      return Right(cachedResponse);
    } catch (cacheError) {
      // If cache fails, fetch from remote
      try {
        final response = await _remoteDataSource.getUserData();

        if (_isSuccessfulResponse(response)) {
          // Save to cache for future use
          await _localDataSource.saveUserDataToCache(response.toDomain());
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(ApiInternalStatus.failure, response.message ?? ''),
          );
        }
      } catch (error) {
        return Left(ExceptionHandler.handle(error).failure);
      }
    }
  }

  // ---------------- UPDATE USER ----------------
  @override
  Future<Either<Failure, void>> updateUser(UpdateUserRequest request) async {
    try {
      await _remoteDataSource.updateUser(request);
      // Clear user data cache after update
      _localDataSource.removeFromCache(CACHE_USER_DATA_KEY);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- CHANGE PASSWORD ----------------
  @override
  Future<Either<Failure, void>> changePassword(
    ChangePasswordRequest request,
  ) async {
    try {
      await _remoteDataSource.changePassword(request);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- LOGOUT ----------------
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteDataSource.logout();
      // Clear all cache on logout
      _localDataSource.clearCache();
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- REPORT BREAKDOWN ----------------
  @override
  Future<Either<Failure, void>> reportBreakDown(
    ReportBreakDownRequest request,
  ) async {
    try {
      await _remoteDataSource.reportBreakDown(request);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- RESCHEDULE APPOINTMENT ----------------
  @override
  Future<Either<Failure, void>> rescheduleAppointment(
    String scheduleDate,
  ) async {
    try {
      await _remoteDataSource.rescheduleAppointment(scheduleDate);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- SAVE FCM TOKEN ----------------
  @override
  Future<Either<Failure, void>> saveFcmToken(String token) async {
    try {
      await _remoteDataSource.saveFcmToken(token);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  // ---------------- GET NOTIFICATIONS ----------------
  @override
  Future<Either<Failure, NotificationsModel>> getNotifications() async {
    try {
      final response = await _remoteDataSource.getNotifications();
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String id) async {
    try {
      await _remoteDataSource.deleteNotification(id);
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> readAllNotification() async {
    try {
      await _remoteDataSource.readAllNotifications();
      return const Right(null);
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, NextAppointmentModel>> nextAppointment() async {
    try {
      // Try to get data from cache first
      final cachedData = await _localDataSource.getNextAppointment();
      return Right(cachedData);
    } catch (cacheError) {
      // If cache fails, fetch from remote
      try {
        final response = await _remoteDataSource.nextAppointment();

        if (_isSuccessfulResponse(response)) {
          final domainModel = response.toDomain();
          // Save to cache for future use
          await _localDataSource.saveNextAppointmentToCache(domainModel);
          return Right(domainModel);
        } else {
          return Left(
            Failure(ApiInternalStatus.failure, response.message ?? ''),
          );
        }
      } catch (error) {
        return Left(ExceptionHandler.handle(error).failure);
      }
    }
  }

  @override
  Future<Either<Failure, LibraryAttachment>> getLibrary() async {
    try {
      final response = await _remoteDataSource.getLibrary();
      print("The success state of lib : ${response.success}");
      return _isSuccessfulResponse(response)
          ? Right(response.toDomain())
          : Left(Failure(ApiInternalStatus.failure, response.message ?? ''));
    } catch (error) {
      return Left(ExceptionHandler.handle(error).failure);
    }
  }
}
