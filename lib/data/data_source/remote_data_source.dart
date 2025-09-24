import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/requests/login_request.dart';
import 'package:elevator/data/network/requests/verify_request.dart';
import 'package:elevator/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequests);
  Future<VerifyResponse> verify(VerifyRequest verifyRequests);
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
}