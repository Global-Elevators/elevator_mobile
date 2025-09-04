import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/requests.dart';
import 'package:elevator/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> register(RegisterRequests registerRequest);
}

class RemoteDataSourceImp extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> register(
    RegisterRequests registerRequest,
  ) async {
    return await _appServicesClient.register(
      registerRequest.name,
      registerRequest.phone,
      registerRequest.email,
      registerRequest.password,
      registerRequest.profilePicture,
    );
  }
}