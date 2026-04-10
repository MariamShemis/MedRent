class AdminDashboardModel {
  final int totalUsers;
  final int totalDoctors;
  final int totalBookings;
  final int totalRental;
  final int totalHospitals;
  final int totalEquipments;
  final double totalRevenue;
  final List<String> monthNames;
  final List<int> monthlyBookings;
  final List<int> monthlyRentals;
  final List<String> weeklyDays;
  final List<int> weeklyBookings;
  final List<String> bookingTypesNames;
  final List<int> bookingTypesCount;

  AdminDashboardModel({
    required this.totalUsers,
    required this.totalDoctors,
    required this.totalBookings,
    required this.totalRental,
    required this.totalHospitals,
    required this.totalEquipments,
    required this.totalRevenue,
    required this.monthNames,
    required this.monthlyBookings,
    required this.monthlyRentals,
    required this.weeklyDays,
    required this.weeklyBookings,
    required this.bookingTypesNames,
    required this.bookingTypesCount,
  });

  factory AdminDashboardModel.fromJson(Map<String, dynamic> json) {
    return AdminDashboardModel(
      totalUsers: json['totalUsers'] ?? 0,
      totalDoctors: json['totalDoctors'] ?? 0,
      totalBookings: json['totalBookings'] ?? 0,
      totalRental: json['totalRental'] ?? 0,
      totalHospitals: json['totalHospitals'] ?? 0,
      totalEquipments: json['totalEquipments'] ?? 0,
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      monthNames: List<String>.from(json['monthNames'] ?? []),
      monthlyBookings: List<int>.from(json['monthlyBookings'] ?? []),
      monthlyRentals: List<int>.from(json['monthlyRentals'] ?? []),
      weeklyDays: List<String>.from(json['weeklyDays'] ?? []),
      weeklyBookings: List<int>.from(json['weeklyBookings'] ?? []),
      bookingTypesNames: (json['bookingTypesNames'] as List)
          .map((e) => e?.toString() ?? "Other")
          .toList(),
      bookingTypesCount: List<int>.from(json['bookingTypesCount'] ?? []),
    );
  }
}