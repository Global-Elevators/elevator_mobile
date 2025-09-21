import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/login_model.dart';

extension CustomerResponseMapper on CustomerDataResponse? {
  Customer toDomain() {
    return Customer(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.otpSent.orFalse() ?? Constants.falseValue,
      this?.code.orEmpty() ?? Constants.empty,
      this?.expiresIn.orZero() ?? Constants.zero,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customerDataResponse.toDomain());
  }
}
