import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) =
      _AppServicesClient;

  @POST("/register") // the endpoint of authentication
  Future<AuthenticationResponse> register(
    @Field("name") String name,
    @Field("phone") String phone,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );
}