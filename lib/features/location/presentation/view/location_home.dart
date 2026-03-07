import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/location/data/cubit/location_cubit.dart';
import 'package:med_rent/features/location/presentation/widgets/custom_icon_button.dart';
import 'package:med_rent/features/location/presentation/widgets/custom_select_location.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/custom_profile_text_form_field.dart';

class LocationHome extends StatefulWidget {
  final Function(String address, LatLng latLng)? onLocationSelected;

  const LocationHome({super.key, this.onLocationSelected});

  @override
  State<LocationHome> createState() => _LocationHomeState();
}

class _LocationHomeState extends State<LocationHome> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  GoogleMapController? _mapController;
  Timer? _debounce;

  final ValueNotifier<Marker?> _selectedMarker = ValueNotifier(null);

  void _updateMarker(LatLng pos, String address) {
    final markerId = const MarkerId("selected");
    final marker = Marker(
      markerId: markerId,
      position: pos,
      draggable: true,
      infoWindow: InfoWindow(title: "الموقع المختار", snippet: address),
      onDragEnd: (newPos) {
        context.read<LocationCubit>().updateSelectedLocation(newPos);
        _mapController?.showMarkerInfoWindow(markerId);
      },
    );
    _selectedMarker.value = marker;

    _mapController?.showMarkerInfoWindow(markerId);
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().length < 3) return;
      context.read<LocationCubit>().searchLocation(value.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    _selectedMarker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        bottom: false,
        top: false,
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading || state is LocationInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationError) {
              return Center(child: Text(state.message));
            } else if (state is LocationLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_selectedMarker.value?.position != state.selectedLocation) {
                  _updateMarker(state.selectedLocation, state.address);
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(state.selectedLocation, 16),
                  );
                }
              });

              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: ValueListenableBuilder<Marker?>(
                        valueListenable: _selectedMarker,
                        builder: (context, marker, _) {
                          return GoogleMap(
                            onMapCreated: (controller) {
                              _mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: state.selectedLocation,
                              zoom: 16,
                            ),
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            markers: marker != null ? {marker} : {},
                            onTap: (pos) {
                              context.read<LocationCubit>().updateSelectedLocation(pos);
                              _updateMarker(pos, state.address);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    left: 20.w,
                    right: 20.w,
                    child: isSearching
                        ? Row(
                      children: [
                        Expanded(
                          child: CustomProfileTextFormField(
                            controller: searchController,
                            hintText: "Search location",
                            onChanged: _onSearchChanged,
                            isLabel: false,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  isSearching = false;
                                });
                              },
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        CustomIconButton(
                          icon: Icons.close,
                          isWhite: false,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 25.w),
                        Text(
                          "Address",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Spacer(),
                        CustomIconButton(
                          icon: Iconsax.search_normal,
                          isWhite: true,
                          onTap: () {
                            setState(() {
                              isSearching = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CustomSelectLocation(
                      textLocation: state.address,
                      onPressed: () async {
                        await context.read<LocationCubit>().saveLocation();
                        if (widget.onLocationSelected != null) {
                          widget.onLocationSelected!(
                            state.address,
                            state.selectedLocation,
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    bottom: 160.h,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          heroTag: "ZoomAdd",
                          backgroundColor: ColorManager.white,
                          foregroundColor: ColorManager.black,
                          onPressed: () {
                            if (_mapController != null) {
                              _mapController!.animateCamera(
                                CameraUpdate.zoomIn(),
                              );
                            }
                          },
                          child: const Icon(Icons.add),
                        ),
                        SizedBox(height: 10.h),
                        FloatingActionButton(
                          mini: true,
                          heroTag: "ZoomMinus",
                          backgroundColor: ColorManager.white,
                          foregroundColor: ColorManager.black,
                          onPressed: () {
                            if (_mapController != null) {
                              _mapController!.animateCamera(
                                CameraUpdate.zoomOut(),
                              );
                            }
                          },
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    top: 80.h,
                    child: FloatingActionButton(
                      mini: true,
                      heroTag: "location",
                      backgroundColor: ColorManager.white,
                      foregroundColor: ColorManager.black,
                      onPressed: () async {
                        final saved = await SessionService.loadSavedLocation();
                        if (saved != null) {
                          final savedLatLng = saved['latLng'] as LatLng;
                          context.read<LocationCubit>().updateSelectedLocation(savedLatLng);
                          _updateMarker(savedLatLng, state.address);
                          if (_mapController != null) {
                            _mapController!.animateCamera(
                              CameraUpdate.newLatLng(savedLatLng),
                            );
                          }
                        }
                      },
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}