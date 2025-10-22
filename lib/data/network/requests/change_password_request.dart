class ChangePasswordRequest {
  String oldPassword;
  String newPassword;
  String newPasswordConfirmation;

  ChangePasswordRequest(this.oldPassword, this.newPassword, this.newPasswordConfirmation);
}
