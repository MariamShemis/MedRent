import 'package:dio/dio.dart';

class AddDeviceOwnerModel {
  final String name;
  final String description;
  final double pricePerDay;
  final String imagePath;

  AddDeviceOwnerModel({
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.imagePath,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'Name': name,
      'Description': description,
      'PricePerDay': pricePerDay,
    "Image": await MultipartFile.fromFile(
        imagePath, 
        filename: imagePath.split('/').last,)
    };
  }
}
