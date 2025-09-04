class Customer {
  String id;
  String name;
  String profilePicture;
  String token;

  Customer(this.id, this.name, this.profilePicture, this.token);
}

class Contacts {
  String phone;
  String email;

  Contacts(this.phone, this.email);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}