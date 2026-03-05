import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;

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
      if (permission != loc.PermissionStatus.granted) throw Exception("Permission denied");
    }

    final locData = await _location.getLocation();
    return LatLng(locData.latitude ?? 30.7865, locData.longitude ?? 31.0004);
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks =
      await geo.placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
      return "Unknown location";
    } catch (_) {
      return "Unknown location";
    }
  }
}