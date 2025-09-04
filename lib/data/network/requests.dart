class LoginRequests {
  String email;
  String password;

  LoginRequests(this.email, this.password);
}

class RegisterRequests {
  String name;
  String phone;
  String email;
  String password;
  String profilePicture;

  RegisterRequests(
    this.name,
    this.phone,
    this.email,
    this.password,
    this.profilePicture,
  );
}
