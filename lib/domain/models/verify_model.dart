class VerifyDataModel {
  final String accessToken;
  final String tokenType;

  VerifyDataModel(this.accessToken, this.tokenType);
}

class VerifyModel {
  final VerifyDataModel? verifyDataModel;

  VerifyModel(this.verifyDataModel);
}
