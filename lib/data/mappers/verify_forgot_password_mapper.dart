import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/verify_forgot_password_model.dart';

extension VerifyDataResponseMapper on VerifyForgotPasswordDataResponse? {
  VerifyForgotPasswordDataModel toDomain() {
    return VerifyForgotPasswordDataModel(
      this?.token.orEmpty() ?? Constants.empty,
      this?.expiresIn.orZero() ?? Constants.zero,
    );
  }
}

extension VerifyResponseMapper on VerifyForgotPasswordResponse? {
  VerifyForgotPasswordModel toDomain() {
    return VerifyForgotPasswordModel(
      this?.verifyForgotPasswordDataResponse.toDomain(),
    );
  }
}
