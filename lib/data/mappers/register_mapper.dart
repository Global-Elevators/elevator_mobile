import 'package:elevator/app/constants.dart';
import 'package:elevator/app/extensions.dart';
import 'package:elevator/data/response/responses.dart';

extension RegisterResponseMapper on RegisterResponse? {
  String toDomain() {
    return this?.registerErrorResponse!.phone!.first.orEmpty() ??
        Constants.empty;
  }
}
