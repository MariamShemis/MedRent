import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class BookingData {
  static const String baseUrl = 'http://GraduationProject.somee.com/api';

  Future<HospitalModel> getHospitalBookingDetails(int hospitalId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Hospital/$hospitalId/booking-details'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return HospitalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load hospital details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<AvailableTimeModel>> getDoctorAvailableTimes({
    required int doctorId,
    required DateTime date,
  }) async {
    try {
      final formattedDate = '${date.month}/${date.day}/${date.year}';
      final response = await http.get(
        Uri.parse('$baseUrl/Hospital/doctor/$doctorId/available-times?date=$formattedDate'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return AvailableTimeModel.fromJsonList(jsonList);
      } else {
        throw Exception('Failed to load available times');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}