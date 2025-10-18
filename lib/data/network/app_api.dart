import 'package:elevator/app/constants.dart';
import 'package:elevator/data/network/requests/register_request.dart';
import 'package:elevator/data/network/requests/request_site_survey_request.dart';
import 'package:elevator/data/network/requests/technical_commercial_offers_request.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) = _AppServicesClient;

  @POST("/auth/login")
  Future<LoginResponse> login(
    @Field("phone") String phone,
    @Field("password") String password,
  );

  @POST("/auth/verify-otp")
  Future<VerifyResponse> verifyOtp(
    @Field("phone") String phone,
    @Field("code") String code,
  );

  @POST("/auth/forgot-password")
  Future<LoginResponse> forgotPassword(@Field("phone") String phone);

  @POST("/auth/verify-forgot-password")
  Future<VerifyForgotPasswordResponse> verifyForgotPassword(
    @Field("phone") String phone,
    @Field("code") String code,
  );

  @POST("/auth/reset-password")
  Future<void> resetPassword(
    @Field("token") String token,
    @Field("password") String password,
    @Field("password_confirmation") String passwordConfirmation,
  );

  @POST("/auth/resend-otp")
  Future<void> resendOtp(@Field("phone") String phone);

  @POST("/auth/register")
  Future<RegisterResponse> register(@Body() UserData userData);

  @POST("/user/site-surveys")
  Future<RequestSiteSurveyResponse> requestSiteSurvey(
    @Body() RequestSiteSurveyRequest request,
  );

  @MultiPart()
  @POST("/user/site-surveys/media")
  Future<UploadMediaResponse> uploadMedia(
    @Part(name: "files[]") List<MultipartFile> files,
  );

  @POST("/user/technical-commercial-offers")
  Future<RequestSiteSurveyResponse> technicalCommercialOffers(
      @Body() TechnicalCommercialOffersRequest request,
      );
}
