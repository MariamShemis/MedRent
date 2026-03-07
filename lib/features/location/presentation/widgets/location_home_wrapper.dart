import 'package:flutter/material.dart';
import 'package:med_rent/features/location/presentation/view/location_home.dart';

class LocationHomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocationHome(
      onLocationSelected: (address, latLng) {
        Navigator.pop(context, {
          "address": address,
          "latLng": latLng,
        });
      },
    );
  }
}