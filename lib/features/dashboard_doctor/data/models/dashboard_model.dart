class DoctorDashboardModel {
  final int totalPatients;
  final int todayBookings;
  final int waitingCount;
  final double rating;
  final List<BookingType> bookingTypes;
  final List<WeeklyBooking> weeklyBookings;
  final List<MonthlyPatient> monthlyPatients;

  DoctorDashboardModel({
    required this.totalPatients,
    required this.todayBookings,
    required this.waitingCount,
    required this.rating,
    required this.bookingTypes,
    required this.weeklyBookings,
    required this.monthlyPatients,
  });

  factory DoctorDashboardModel.fromJson(Map<String, dynamic> json) {
    return DoctorDashboardModel(
      totalPatients: json['totalPatients'],
      todayBookings: json['todayBookings'],
      waitingCount: json['waitingCount'],
      rating: (json['rating'] as num).toDouble(),
      bookingTypes: (json['bookingTypes'] as List)
          .map((e) => BookingType.fromJson(e))
          .toList(),
      weeklyBookings: (json['weeklyBookings'] as List)
          .map((e) => WeeklyBooking.fromJson(e))
          .toList(),
      monthlyPatients: (json['monthlyPatients'] as List)
          .map((e) => MonthlyPatient.fromJson(e))
          .toList(),
    );
  }
}

class BookingType {
  final String type;
  final int count;

  BookingType({required this.type, required this.count});

  factory BookingType.fromJson(Map<String, dynamic> json) {
    return BookingType(
      type: json['type'],
      count: json['count'],
    );
  }
}

class WeeklyBooking {
  final String day;
  final int count;

  WeeklyBooking({required this.day, required this.count});

  factory WeeklyBooking.fromJson(Map<String, dynamic> json) {
    return WeeklyBooking(
      day: json['day'],
      count: json['count'],
    );
  }
}

class MonthlyPatient {
  final int month;
  final int count;

  MonthlyPatient({required this.month, required this.count});

  factory MonthlyPatient.fromJson(Map<String, dynamic> json) {
    return MonthlyPatient(
      month: json['month'],
      count: json['count'],
    );
  }
}