import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/verify_model.dart';

extension VerifyDataResponseMapper on VerifyDataResponse? {
  VerifyDataModel toDomain() {
    return VerifyDataModel(
      this?.accessToken.orEmpty() ?? Constants.empty,
      this?.tokenType.orEmpty() ?? Constants.empty,
    );
  }
}

extension VerifyResponseMapper on VerifyResponse? {
  VerifyModel toDomain() {
    return VerifyModel(this?.verifyDataResponse.toDomain());
  }
}
