import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';
@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String phone, String password) = _LoginObject;
}

@freezed
class VerifyObject with _$VerifyObject {
  factory VerifyObject(String phone, String code) = _VerifyObject;
}