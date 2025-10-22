import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:elevator/data/network/failure.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/data/network/requests/technical_commercial_offers_request.dart' hide UserInfo;
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/domain/models/login_model.dart';
import 'package:elevator/domain/models/upload_media_model.dart';
import 'package:elevator/domain/models/verify_forgot_password_model.dart';
import 'package:elevator/domain/models/verify_model.dart';
import 'package:elevator/domain/models/user_data_model.dart';
import 'package:elevator/data/network/requests/update_user_request.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, VerifyModel>> verify(VerifyRequest verifyRequests);

  Future<Either<Failure, Authentication>> forgotPassword(String phone);

  Future<Either<Failure, VerifyForgotPasswordModel>> verifyForgotPassword(
    VerifyRequest verifyForgotPasswordRequest,
  );

  Future<Either<Failure, void>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  );

  Future<Either<Failure, void>> resendOtp(String phone);

  Future<Either<Failure, void>> register(UserData userData);

  Future<Either<Failure, void>> requestSiteSurvey(
    RequestSiteSurveyRequest request,
  );

  Future<Either<Failure, void>> technicalCommercialOffers(
    TechnicalCommercialOffersRequest request,
  );

  Future<Either<Failure, UploadMediaModel>> uploadMedia(
    List<MultipartFile> files,
  );

  Future<Either<Failure, void>> sos();

  Future<Either<Failure, GetUserInfo>> getUserData();

  Future<Either<Failure, void>> updateUser(UpdateUserRequest request);
}
