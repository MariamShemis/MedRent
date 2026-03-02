import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SelectLocationMap extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const SelectLocationMap({super.key, required this.onLocationSelected});

  @override
  State<SelectLocationMap> createState() => _SelectLocationMapState();
}

class _SelectLocationMapState extends State<SelectLocationMap> {
  late GoogleMapController mapController;
  LatLng? selectedPosition;
  LatLng initialPosition = const LatLng(30.7865, 31.0004); // طنطا افتراضي

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  Future<void> _initCurrentLocation() async {
    try {
      Position pos = await determinePosition();
      setState(() {
        initialPosition = LatLng(pos.latitude, pos.longitude);
        selectedPosition = initialPosition;
      });
    } catch (e) {
      // لو رفض المستخدم الموقع، يبقى الافتراضي موجود
    }
  }
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, cannot request.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: GoogleMap(

        initialCameraPosition: CameraPosition(
          target: selectedPosition ?? initialPosition,
          zoom: 16,
        ),
        onMapCreated: (controller) => mapController = controller,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: selectedPosition != null
            ? {
          Marker(
            markerId: const MarkerId("selected"),
            position: selectedPosition!,
            draggable: true,
            onDragEnd: (newPos) {
              setState(() {
                selectedPosition = newPos;
              });
              widget.onLocationSelected(newPos);
            },
          ),
        }
            : {},
        onTap: (latLng) {
          setState(() {
            selectedPosition = latLng;
          });
          widget.onLocationSelected(latLng);
        },
      ),
    );
  }
}