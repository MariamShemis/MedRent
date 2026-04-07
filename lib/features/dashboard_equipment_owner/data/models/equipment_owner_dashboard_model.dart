class EquipmentOwnerDashboardModel {
  final int totalDevices;
  final int todayRentals;
  final int pendingRentals;
  final double rating;
  final List<RentalType> rentalTypes;
  final List<WeeklyRental> weeklyRentals;

  EquipmentOwnerDashboardModel({
    required this.totalDevices,
    required this.todayRentals,
    required this.pendingRentals,
    required this.rating,
    required this.rentalTypes,
    required this.weeklyRentals,
  });

  factory EquipmentOwnerDashboardModel.fromJson(Map<String, dynamic> json) {
    return EquipmentOwnerDashboardModel(
      totalDevices: json['totalDevices'] ?? 0,
      todayRentals: json['todayRentals'] ?? 0,
      pendingRentals: json['pendingRentals'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      rentalTypes: (json['rentalTypes'] as List? ?? [])
          .map((e) => RentalType.fromJson(e))
          .toList(),
      weeklyRentals: (json['weeklyRentals'] as List? ?? [])
          .map((e) => WeeklyRental.fromJson(e))
          .toList(),
    );
  }
}

class RentalType {
  final String type;
  final int count;

  RentalType({required this.type, required this.count});

  factory RentalType.fromJson(Map<String, dynamic> json) {
    return RentalType(
      type: json['type'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}

class WeeklyRental {
  final String day;
  final int count;

  WeeklyRental({required this.day, required this.count});

  factory WeeklyRental.fromJson(Map<String, dynamic> json) {
    return WeeklyRental(
      day: json['day'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}