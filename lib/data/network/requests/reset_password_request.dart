class ResetPasswordRequest {
  String token;
  String password;
  String passwordConfirmation;

  ResetPasswordRequest(this.token, this.password, this.passwordConfirmation);
}