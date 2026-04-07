import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/contact_us/data/models/contact_us_model.dart';

class ContactUsDataSource {
  final ApiClient _apiClient;

  ContactUsDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  Future<String> sendMessage(ContactUsModel model) async {
    try {
      final response = await _apiClient.post(
        '/ContactUs',
        data: model.toJson(),
      );

      return response.data.toString();
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data.toString());
      } else {
        throw Exception("Network error");
      }
    }
  }
}