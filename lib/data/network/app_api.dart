import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) = _AppServicesClient;

  @POST("/auth/login")
  Future<AuthenticationResponse> login(
      @Field("phone") String phone,
      @Field("password") String password,
      );

  @POST("/auth/verify-otp")
  Future<VerifyResponse> verifyOtp(
    @Field("phone") String phone,
    @Field("code") String code,
  );
}