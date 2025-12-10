import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/request_status_model.dart';
import 'package:elevator/app/extensions.dart';

extension RequestStatusResponseMapper on RequestStatusResponse? {
  RequestStatusModel toDomain() {
    return RequestStatusModel(
      this?.data.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension RequestStatusDataResponseMapper on RequestStatusDataResponse? {
  RequestStatusDataModel toDomain() {
    return RequestStatusDataModel(
      id: this?.id ?? Constants.zero,
      label: this?.label.orEmpty() ?? Constants.empty,
      status: this?.status.orEmpty() ?? Constants.empty,
      createdAt: this?.createdAt ?? DateTime.now(),
    );
  }
}
