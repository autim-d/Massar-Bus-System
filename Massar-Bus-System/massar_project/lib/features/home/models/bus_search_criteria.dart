class BusSearchCriteria {
  final String? fromId;
  final String? toId;
  final String from;
  final String to;
  final DateTime date;

  BusSearchCriteria({
    this.fromId,
    this.toId,
    required this.from,
    required this.to,
    required this.date,
  });

  BusSearchCriteria copyWith({
    String? fromId,
    String? toId,
    String? from,
    String? to,
    DateTime? date,
  }) {
    return BusSearchCriteria(
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
    );
  }
}
