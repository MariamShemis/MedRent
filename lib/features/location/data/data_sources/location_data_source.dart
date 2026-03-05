import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class LocationDataSource {
  final loc.Location _location = loc.Location();

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) throw Exception("Location service disabled");
    }

    loc.PermissionStatus permission = await _location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != loc.PermissionStatus.granted)
        throw Exception("Permission denied");
    }

    final locData = await _location.getLocation();
    return LatLng(locData.latitude ?? 30.7865, locData.longitude ?? 31.0004);
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
      return "Unknown location";
    } catch (_) {
      return "Unknown location";
    }
  }

  Future<LatLng?> searchLocation(String query) async {
    const apiKey = "AIzaSyAaPcLU7xqPNI79aLH-70XPc5Nj91sKQNk";
    Dio dio = Dio();

    final url =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          "input": query,
          "inputtype": "textquery",
          "fields": "geometry",
          "key": apiKey,
        },
      );

      final data = response.data;

      if (data["candidates"] != null && data["candidates"].isNotEmpty) {
        final location = data["candidates"][0]["geometry"]["location"];

        return LatLng(location["lat"], location["lng"]);
      }
    } catch (e) {
      throw Exception(e.toString());
    }

    return null;
  }
}
