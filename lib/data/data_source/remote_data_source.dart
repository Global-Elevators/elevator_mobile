import 'package:dio/dio.dart';
import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/data/network/requests/technical_commercial_offers_request.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequests);

  Future<VerifyResponse> verify(VerifyRequest verifyRequests);

  Future<LoginResponse> forgotPassword(String phone);

  Future<VerifyForgotPasswordResponse> verifyForgotPassword(
    VerifyRequest verifyForgotPasswordRequest,
  );

  Future<void> resetPassword(ResetPasswordRequest resetPasswordRequest);

  Future<void> resendOtp(String phone);

  Future<RegisterResponse> register(UserData userData);

  Future<RequestSiteSurveyResponse> requestSiteSurvey(
    RequestSiteSurveyRequest request,
  );

  Future<RequestSiteSurveyResponse> technicalCommercialOffers(
    TechnicalCommercialOffersRequest request,
  );

  Future<UploadMediaResponse> uploadMedia(List<MultipartFile> files);

  Future<void> sos();
}

class RemoteDataSourceImp extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequests) async {
    return await _appServicesClient.login(
      loginRequests.phone,
      loginRequests.password,
    );
  }

  @override
  Future<VerifyResponse> verify(VerifyRequest verifyRequests) async {
    return await _appServicesClient.verifyOtp(
      verifyRequests.phone,
      verifyRequests.code,
    );
  }

  @override
  Future<LoginResponse> forgotPassword(String phone) {
    return _appServicesClient.forgotPassword(phone);
  }

  @override
  Future<VerifyForgotPasswordResponse> verifyForgotPassword(
    VerifyRequest verifyForgotPasswordRequest,
  ) {
    return _appServicesClient.verifyForgotPassword(
      verifyForgotPasswordRequest.phone,
      verifyForgotPasswordRequest.code,
    );
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest resetPasswordRequest) {
    return _appServicesClient.resetPassword(
      resetPasswordRequest.token,
      resetPasswordRequest.password,
      resetPasswordRequest.passwordConfirmation,
    );
  }

  @override
  Future<void> resendOtp(String phone) async {
    return await _appServicesClient.resendOtp(phone);
  }

  @override
  Future<RegisterResponse> register(UserData userData) async {
    return await _appServicesClient.register(userData);
  }

  @override
  Future<RequestSiteSurveyResponse> requestSiteSurvey(
    RequestSiteSurveyRequest request,
  ) async {
    return await _appServicesClient.requestSiteSurvey(request);
  }

  @override
  Future<UploadMediaResponse> uploadMedia(List<MultipartFile> files) async {
    return await _appServicesClient.uploadMedia(files);
  }

  @override
  Future<RequestSiteSurveyResponse> technicalCommercialOffers(
    TechnicalCommercialOffersRequest request,
  ) async {
    return await _appServicesClient.technicalCommercialOffers(request);
  }

  @override
  Future<void> sos() async {
    return await _appServicesClient.sos();
  }
}
