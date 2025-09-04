import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/register_model.dart';
import 'package:elevator/app/extensions.dart';

extension CustomerResponseMapper on CustomerDataResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.profilePicture.orEmpty() ?? Constants.empty,
      this?.token.orEmpty() ?? Constants.empty,
    );
  }
}

extension ContactsResponseMapper on ContactsDataResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customerDataResponse.toDomain(),
      this?.contactsDataResponse.toDomain(),
    );
  }
}
