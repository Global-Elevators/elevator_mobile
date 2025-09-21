class Customer {
  String phone;
  bool otpSent;
  String code;
  int expiresIn;

  Customer(this.phone, this.otpSent, this.code, this.expiresIn);
}

class Authentication {
  Customer? customer;

  Authentication(this.customer);
}
