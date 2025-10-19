import 'package:elevator/domain/models/base__model.dart';

class UserProfile {
  String sirName;
  String lastName;

  UserProfile(this.sirName, this.lastName);
}

class User extends BaseModel {
  int id;
  String name;
  String? email;
  String phone;
  String address;
  String birthdate;
  UserProfile? profile;

  User(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.birthdate,
    this.profile,
  );
}

class GetUserInfo {
  User? user;

  GetUserInfo(this.user);
}
