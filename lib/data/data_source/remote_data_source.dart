import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/reset_password_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequests);
  Future<VerifyResponse> verify(VerifyRequest verifyRequests);
  Future<AuthenticationResponse> forgotPassword(String phone);
  Future<VerifyForgotPasswordResponse> verifyForgotPassword(VerifyRequest verifyForgotPasswordRequest);
  Future<void> resetPassword(ResetPasswordRequest resetPasswordRequest);
  Future<void> resendOtp(String phone);
}

class RemoteDataSourceImp extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequests) async{
    return await _appServicesClient.login(
      loginRequests.phone,
      loginRequests.password,
    );
  }

  @override
  Future<VerifyResponse> verify(VerifyRequest verifyRequests) async{
    return await _appServicesClient.verifyOtp(
      verifyRequests.phone,
      verifyRequests.code,
    );
  }

  @override
  Future<AuthenticationResponse> forgotPassword(String phone) {
    return _appServicesClient.forgotPassword(phone);
  }

  @override
  Future<VerifyForgotPasswordResponse> verifyForgotPassword(VerifyRequest verifyForgotPasswordRequest) {
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
  Future<void> resendOtp(String phone) async{
    return await _appServicesClient.resendOtp(phone);
  }
}