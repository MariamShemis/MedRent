class AvailabilityModel {
  final List<DateTime> bookedDates;

  AvailabilityModel({
    required this.bookedDates,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    List<DateTime> dates = [];
    if (json['bookedDates'] != null && json['bookedDates'] is List) {
      dates = (json['bookedDates'] as List)
          .map((date) => DateTime.parse(date))
          .toList();
    }
    return AvailabilityModel(bookedDates: dates);
  }
}