class ContractsStatusModel {
  final List<ContractsStatusDataModel> contracts;

  ContractsStatusModel(this.contracts);
}

class ContractsStatusDataModel {
  final int id;
  final StatusModel status;
  final DateTime startDate;
  final DateTime endDate;
  final TimelineModel timeline;

  ContractsStatusDataModel({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.timeline,
  });
}

class StatusModel {
  final String value;
  final String label;
  final String color;

  StatusModel({required this.value, required this.label, required this.color});
}

class TimelineModel {
  final String scopeLabel;
  final String currentStatusLabel;
  final List<ItemModel> items;

  TimelineModel({
    required this.scopeLabel,
    required this.currentStatusLabel,
    required this.items,
  });
}

class ItemModel {
  final String value;
  final String label;
  final String icon;
  final String color;
  final String state;
  final DateTime deadline;

  ItemModel({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.state,
    required this.deadline,
  });
}
