import 'package:dio/dio.dart';
import 'package:med_rent/features/contact_us/data/models/contact_us_model.dart';

class ContactUsDataSource {
  final Dio dio;
  ContactUsDataSource(this.dio);
  Future<String> sendMessage(ContactUsModel model) async {
    try {
      final response = await dio.post(
        "http://graduationprojectapi.somee.com/api/ContactUs",
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