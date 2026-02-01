class EquipmentAvailability {
  final List<String> bookedDates;

  EquipmentAvailability({
    required this.bookedDates,
  });

  factory EquipmentAvailability.fromJson(Map<String, dynamic> json) {
    return EquipmentAvailability(
      bookedDates: List<String>.from(json['bookedDates']),
    );
  }

  List<DateTime> get bookedDatesAsDateTime {
    return bookedDates.map((date) => DateTime.parse(date)).toList();
  }
}