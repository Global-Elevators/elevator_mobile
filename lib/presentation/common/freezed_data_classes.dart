import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String email,
    String password,
    String userName,
    String mobileNumber,
    String profilePicture,
  ) = _RegisterObject;
}

// An immutable class is a class whose instances cannot be modified after they are created. Once an object of an immutable class is initialized, its state (the values of its fields) cannot be changed

/*
* freezed is used to generate immutable data classes. For example, the LoginObject class is immutable because:
* Its fields (email and password) cannot be modified after the object is created because they are final fields in the _$LoginObject class.
*/
