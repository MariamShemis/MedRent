import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/location/data/data_sources/location_data_source.dart';
import 'package:meta/meta.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationDataSource _repository;

  LocationCubit(this._repository) : super(LocationInitial());

  Future<void> getCurrentLocation() async {
    emit(LocationLoading());
    try {
      final saved = await SessionService.loadSavedLocation();
      if (saved != null) {
        emit(LocationLoaded(
          currentLocation: saved['latLng'],
          selectedLocation: saved['latLng'],
          address: saved['address'],
        ));
        return;
      }

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
    if (query.trim().length < 3) return;

    try {
      final latLng = await _repository.searchLocation(query);
      if (latLng == null) return;

      final address = await _repository.getAddressFromLatLng(latLng);
      final currentState = state as LocationLoaded;

      emit(LocationLoaded(
        currentLocation: currentState.currentLocation,
        selectedLocation: latLng,
        address: address,
      ));
    } catch (_) {
      emit(LocationError("Could not find any result for '$query'"));
    }
  }

  Future<void> saveLocation() async {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      await SessionService.saveLocation(
        currentState.address,
        currentState.selectedLocation,
      );
    }
  }
}