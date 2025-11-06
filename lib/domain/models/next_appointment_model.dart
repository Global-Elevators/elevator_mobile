class NextAppointmentModel {
  NextAppointmentDataModel? nextAppointmentDataModel;

  NextAppointmentModel(this.nextAppointmentDataModel);
}

class NextAppointmentDataModel {
  int id;
  int siteSurveyId;
  String projectAddress;
  String scheduleDate;
  String daysLeft;
  String contractStatus;

  NextAppointmentDataModel({
    required this.id,
    required this.siteSurveyId,
    required this.projectAddress,
    required this.scheduleDate,
    required this.daysLeft,
    required this.contractStatus,
  });
}
