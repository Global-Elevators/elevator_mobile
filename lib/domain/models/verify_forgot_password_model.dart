import 'package:elevator/domain/models/base__model.dart';

class VerifyForgotPasswordDataModel extends BaseModel{
  final String token;
  final int expiresIn;

  VerifyForgotPasswordDataModel(this.token, this.expiresIn);
}

class VerifyForgotPasswordModel {
  final VerifyForgotPasswordDataModel? verifyForgotPasswordDataModel;

  VerifyForgotPasswordModel(this.verifyForgotPasswordDataModel);
}
