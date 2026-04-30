class BusSearchCriteria {
  final String from;
  final String to;
  final DateTime date;
  // دعم البحث بـ station ID (للربط مع API)
  final String? fromId;
  final String? toId;
  final String? passengerName;
  final String? passengerPhone;

  BusSearchCriteria({
    required this.from,
    required this.to,
    required this.date,
    this.fromId,
    this.toId,
    this.passengerName,
    this.passengerPhone,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusSearchCriteria &&
      other.from == from &&
      other.to == to &&
      other.date == date &&
      other.fromId == fromId &&
      other.toId == toId &&
      other.passengerName == passengerName &&
      other.passengerPhone == passengerPhone;
  }

  @override
  int get hashCode => 
    from.hashCode ^ 
    to.hashCode ^ 
    date.hashCode ^ 
    (fromId?.hashCode ?? 0) ^ 
    (toId?.hashCode ?? 0) ^
    (passengerName?.hashCode ?? 0) ^
    (passengerPhone?.hashCode ?? 0);
}
