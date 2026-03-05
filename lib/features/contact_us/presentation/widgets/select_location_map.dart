import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:med_rent/features/location/data/cubit/location_cubit.dart';
import 'package:med_rent/features/location/data/data_sources/location_data_source.dart';

class SelectLocationMap extends StatelessWidget {
  final Function(LatLng) onLocationSelected;
  final double height;

  const SelectLocationMap({
    super.key,
    required this.onLocationSelected,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(LocationDataSource())..getCurrentLocation(),
      child: SizedBox(
        height: height,
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LocationError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is LocationLoaded) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: state.selectedLocation,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: {
                    Marker(
                      markerId: const MarkerId("selected"),
                      position: state.selectedLocation,
                      draggable: true,
                      onDragEnd: (newPos) {
                        context
                            .read<LocationCubit>()
                            .updateSelectedLocation(newPos);
                
                        onLocationSelected(newPos);
                      },
                    ),
                  },
                  onTap: (latLng) {
                    context
                        .read<LocationCubit>()
                        .updateSelectedLocation(latLng);
                
                    onLocationSelected(latLng);
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}