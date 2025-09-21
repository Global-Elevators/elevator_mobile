import 'package:elevator/data/network/app_api.dart';
import 'package:elevator/data/network/requests.dart';
import 'package:elevator/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

class RemoteDataSourceImp extends RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async{
    return await _appServicesClient.login(
      loginRequests.phone,
      loginRequests.password,
    );
  }
}
