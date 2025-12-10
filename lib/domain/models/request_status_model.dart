class RequestStatusModel {
  final List<RequestStatusDataModel> requests;

  RequestStatusModel(this.requests);
}

class RequestStatusDataModel {
  final int id;
  final String label;
  final String status;
  final DateTime createdAt;

  RequestStatusDataModel({
    required this.id,
    required this.label,
    required this.status,
    required this.createdAt,
  });
}
