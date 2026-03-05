import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/features/location/data/cubit/location_cubit.dart';
import 'package:med_rent/features/location/presentation/widgets/custom_icon_button.dart';
import 'package:med_rent/features/location/presentation/widgets/custom_select_location.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/custom_profile_text_form_field.dart';

class LocationHome extends StatefulWidget {
  const LocationHome({super.key});

  @override
  State<LocationHome> createState() => _LocationHomeState();
}

class _LocationHomeState extends State<LocationHome> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading || state is LocationInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LocationError) {
              return Center(child: Text(state.message));
            } else if (state is LocationLoaded) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
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
                            },
                          ),
                        },
                        onTap: (pos) {
                          context.read<LocationCubit>().updateSelectedLocation(
                            pos,
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
                                  keyboardType: TextInputType.text,
                                  isLabel: false,
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        isSearching = false;
                                      });
                                    },
                                  ),
                                  onChanged: (value) async {
                                    final result = await context
                                        .read<LocationCubit>()
                                        .searchLocation(value);
                                    if (result != null) {
                                      context
                                          .read<LocationCubit>()
                                          .updateSelectedLocation(result);
                                    }
                                    // setState(() {
                                    //   isSearching = false;
                                    // });
                                  },
                                ),
                              ),
                              // Expanded(
                              //   child: TextField(
                              //     controller: searchController,
                              //     decoration: InputDecoration(
                              //       hintText: "Search location",
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //       ),
                              //     ),
                              //     onSubmitted: (value) async {
                              //       final result = await context
                              //           .read<LocationCubit>()
                              //           .searchLocation(value);
                              //       if (result != null) {
                              //         context
                              //             .read<LocationCubit>()
                              //             .updateSelectedLocation(result);
                              //       }
                              //       setState(() {
                              //         isSearching = false;
                              //       });
                              //     },
                              //   ),
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.close),
                              //   onPressed: () {
                              //     setState(() {
                              //       isSearching = false;
                              //     });
                              //   },
                              // ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomIconButton(
                                icon: Icons.close,
                                isWhite: false,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
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
                      onPressed: () {
                        print("Selected Location: ${state.selectedLocation}");
                      },
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
