import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationMap extends StatefulWidget {
  final double height;

  const SelectLocationMap({
    super.key,
    this.height = 300,
  });

  @override
  State<SelectLocationMap> createState() => _SelectLocationMapState();
}

class _SelectLocationMapState extends State<SelectLocationMap> {
  static const LatLng fcisTanta = LatLng(30.9997, 31.0022);
  final MarkerId markerId = const MarkerId("fcis_tanta");
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: GoogleMap(
          onMapCreated: (controller) {
            mapController = controller;
            // عرض infoWindow تلقائي
            mapController.showMarkerInfoWindow(markerId);
          },
          initialCameraPosition: const CameraPosition(
            target: fcisTanta,
            zoom: 17,
          ),
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          markers: {
            Marker(
              markerId: markerId,
              position: fcisTanta,
              infoWindow: const InfoWindow(
                title: "كلية الحاسبات والمعلومات",
                snippet: "جامعة طنطا",
              ),
            ),
          },
        ),
      ),
    );
  }
}