import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_rent/features/location/data/data_sources/location_data_source.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationDataSource _repository;
  LocationCubit(this._repository) : super(LocationInitial());

  Future<void> getCurrentLocation() async {
    emit(LocationLoading());
    try {
      final latLng = await _repository.getCurrentLocation();
      final address = await _repository.getAddressFromLatLng(latLng);
      emit(LocationLoaded(
        currentLocation: latLng,
        selectedLocation: latLng,
        address: address,
      ));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> updateSelectedLocation(LatLng latLng) async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      final address = await _repository.getAddressFromLatLng(latLng);
      emit(LocationLoaded(
        currentLocation: currentState.currentLocation,
        selectedLocation: latLng,
        address: address,
      ));
    }
  }

  Future<void> searchLocation(String query) async {
    if (state is! LocationLoaded) return;

    try {
      final locations = await geo.locationFromAddress(query);

      if (locations.isEmpty) return;

      final loc = locations.first;
      final latLng = LatLng(loc.latitude, loc.longitude);

      final address = await _repository.getAddressFromLatLng(latLng);

      final currentState = state as LocationLoaded;

      emit(
        LocationLoaded(
          currentLocation: currentState.currentLocation,
          selectedLocation: latLng,
          address: address,
        ),
      );
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

}