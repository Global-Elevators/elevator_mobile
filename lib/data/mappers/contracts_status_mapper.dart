import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/contracts_status_model.dart';
import 'package:elevator/app/extensions.dart';

extension ContractsStatusResponseMapper on ContractsStatusResponse? {
  ContractsStatusModel toDomain() {
    return ContractsStatusModel(
      this?.data.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ContractsStatusDataResponseMapper on ContractsStatusDataResponse? {
  ContractsStatusDataModel toDomain() {
    return ContractsStatusDataModel(
      id: this?.id ?? Constants.zero,
      status:
          this?.status.toDomain() ??
          StatusModel(
            value: Constants.empty,
            label: Constants.empty,
            color: Constants.empty,
          ),
      startDate: this?.startDate ?? DateTime.now(),
      endDate: this?.endDate ?? DateTime.now(),
      timeline:
          this?.timeline.toDomain() ??
          TimelineModel(
            scopeLabel: Constants.empty,
            currentStatusLabel: Constants.empty,
            items: [],
          ),
    );
  }
}

extension StatusResponseMapper on Status? {
  StatusModel toDomain() {
    return StatusModel(
      value: this?.value.orEmpty() ?? Constants.empty,
      label: this?.label.orEmpty() ?? Constants.empty,
      color: this?.color.orEmpty() ?? Constants.empty,
    );
  }
}

extension TimelineResponseMapper on Timeline? {
  TimelineModel toDomain() {
    return TimelineModel(
      scopeLabel: this?.scopeLabel.orEmpty() ?? Constants.empty,
      currentStatusLabel: this?.currentStatusLabel.orEmpty() ?? Constants.empty,
      items: this?.items?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension ItemResponseMapper on Item? {
  ItemModel toDomain() {
    return ItemModel(
      value: this?.value.orEmpty() ?? Constants.empty,
      label: this?.label.orEmpty() ?? Constants.empty,
      icon: this?.icon.orEmpty() ?? Constants.empty,
      color: this?.color.orEmpty() ?? Constants.empty,
      state: this?.state.orEmpty() ?? Constants.empty,
      deadline: this?.deadline ?? DateTime.now(),
    );
  }
}
