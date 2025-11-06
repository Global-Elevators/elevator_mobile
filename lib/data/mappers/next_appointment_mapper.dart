import 'package:elevator/app/constants.dart';
import 'package:elevator/data/response/responses.dart';
import 'package:elevator/domain/models/next_appointment_model.dart';
import 'package:elevator/app/extensions.dart';

extension NextAppointmentResponseMapper on NextAppointmentResponse? {
  NextAppointmentModel toDomain() {
    return NextAppointmentModel(this?.nextAppointmentDataResponse.toDomain());
  }
}

extension NextAppointmentDataResponseMapper on NextAppointmentDataResponse? {
  NextAppointmentDataModel toDomain() {
    return NextAppointmentDataModel(
      id: this?.id.orZero() ?? Constants.zero,
      siteSurveyId: this?.siteSurveyId.orZero() ?? Constants.zero,
      projectAddress: this?.projectAddress.orEmpty() ?? Constants.empty,
      scheduleDate: this?.scheduleDate.orEmpty() ?? Constants.empty,
      daysLeft: this?.daysLeft.orEmpty() ?? Constants.empty,
      contractStatus: this?.contractStatus.orEmpty() ?? Constants.empty,
    );
  }
}
