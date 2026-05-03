class BusSearchCriteria {
  final String? fromId;
  final String? toId;
  final DateTime date;

  BusSearchCriteria({
    this.fromId,
    this.toId,
    required this.date,
  });
}
