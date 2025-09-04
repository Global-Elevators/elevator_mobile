import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerDataResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "profilePicture")
  String? profilePicture;
  @JsonKey(name: "token")
  String? token;

  CustomerDataResponse(this.id, this.name, this.profilePicture, this.token);

  factory CustomerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataResponseToJson(this);
}

@JsonSerializable()
class ContactsDataResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;

  ContactsDataResponse(this.phone, this.email);

  factory ContactsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsDataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerDataResponse? customerDataResponse;
  @JsonKey(name: "contacts")
  ContactsDataResponse? contactsDataResponse;

  AuthenticationResponse(this.customerDataResponse, this.contactsDataResponse);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
