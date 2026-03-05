part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final LatLng currentLocation;
  final LatLng selectedLocation;
  final String address;

  LocationLoaded({
    required this.currentLocation,
    required this.selectedLocation,
    required this.address,
  });
}

final class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}