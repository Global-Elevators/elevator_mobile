import 'package:elevator/domain/models/base__model.dart';

class VerifyDataModel extends BaseModel{
  final String accessToken;
  final String tokenType;

  VerifyDataModel(this.accessToken, this.tokenType);
}

class VerifyModel {
  final VerifyDataModel? verifyDataModel;

  VerifyModel(this.verifyDataModel);
}
