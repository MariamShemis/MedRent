import 'package:dio/dio.dart';

class AddDeviceModel {
  final String name;
  final String description;
  final double pricePerDay;
  final String imagePath; // مسار الصورة في الموبايل
  final String ownerName;
  final String ownerEmail;
  final String ownerPassword;
  final String ownerPhone;

  AddDeviceModel({
    required this.name,
    required this.description,
    required this.pricePerDay,
    required this.imagePath,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerPassword,
    required this.ownerPhone,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      "Name": name,
      "Description": description,
      "PricePerDay": pricePerDay,
      "OwnerName": ownerName,
      "OwnerEmail": ownerEmail,
      "OwnerPassword": ownerPassword,
      "OwnerPhone": ownerPhone,
      "Image": await MultipartFile.fromFile(
        imagePath, 
        filename: imagePath.split('/').last,
      ),
    };
    }
  }
