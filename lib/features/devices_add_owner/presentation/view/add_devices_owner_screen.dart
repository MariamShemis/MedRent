import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/admin_add_doctor/presentation/widgets/card_add_image.dart';
import 'package:med_rent/features/devices_add_owner/data/cubit/owner_add_devices_cubit.dart';
import 'package:med_rent/features/devices_add_owner/data/data_source/add_device_owner_service.dart';
import 'package:med_rent/features/devices_add_owner/presentation/widget/custom_add_devices_text_field_owner.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AddDevicesOwnerScreen extends StatefulWidget {
  const AddDevicesOwnerScreen({super.key});

  @override
  State<AddDevicesOwnerScreen> createState() => _AddDevicesOwnerScreenState();
}

class _AddDevicesOwnerScreenState extends State<AddDevicesOwnerScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) =>
          OwnerAddDevicesCubit(AddDeviceOwnerService(ApiClient())),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorManager.darkBlue,
            ),
          ),
          titleSpacing: 0,
          title: Text(
            appLocalizations.addNewDevice,
            style: TextStyle(
              color: ColorManager.darkBlue,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocConsumer<OwnerAddDevicesCubit, OwnerAddDevicesState>(
          listener: (context, state) {
            if (state is OwnerAddDevicesSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.isEmpty ? "Success" : state.message,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is OwnerAddDevicesFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.isEmpty ? "An error occurred" : state.message,
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<OwnerAddDevicesCubit>();
            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: REdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardAddImage(
                      text: appLocalizations.deviceImage,
                      onTap: () => _showBottomSheetImage(context, cubit),
                      image: cubit.pickedImagePath != null
                          ? File(cubit.pickedImagePath!)
                          : null,
                    ),
                    SizedBox(height: 14.h),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      color: ColorManager.white,
                      elevation: 5,
                      child: Padding(
                        padding: REdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              appLocalizations.deviceInformation,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 20.h),
                            CustomAddDevicesTextFieldOwner(
                              controller: nameController,
                              hintText: appLocalizations.enter_name_of_device,
                              keyboardType: TextInputType.text,
                              labelName: appLocalizations.name,
                            ),
                            SizedBox(height: 12.h),
                            CustomAddDevicesTextFieldOwner(
                              controller: priceController,
                              hintText: appLocalizations.enter_price_of_device,
                              keyboardType: TextInputType.number,
                              labelName: appLocalizations.price,
                            ),
                            SizedBox(height: 12.h),
                            CustomAddDevicesTextFieldOwner(
                              controller: descriptionController,
                              hintText: appLocalizations
                                  .enter_a_detailed_description_of_the_device,
                              keyboardType: TextInputType.multiline,
                              labelName: appLocalizations.description,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    state is OwnerAddDevicesLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.darkBlue,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              String? token =
                                  await SessionService.getAuthToken();
                              if (token != null && token.isNotEmpty) {
                                cubit.addDeviceOwner(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  price:
                                      double.tryParse(priceController.text) ??
                                      0.0,
                                  token: token,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Session expired. Please login again.",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(appLocalizations.addDevice),
                                SizedBox(width: 10.w),
                                const Icon(Icons.upload, color: Colors.white),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showBottomSheetImage(BuildContext context, OwnerAddDevicesCubit cubit) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) => Padding(
      padding: REdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة
              cubit.pickImageOwner(
                sources: ImageSource.camera,
              ); // اختيار كاميرا
            },
            child: Row(
              children: [
                const Icon(Icons.photo_camera_outlined),
                SizedBox(width: 10.w),
                const Text("Take a photo"),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              cubit.pickImageOwner(sources: ImageSource.gallery); // اختيار معرض
            },
            child: Row(
              children: [
                const Icon(Icons.photo_library_outlined),
                SizedBox(width: 10.w),
                const Text("Choose from gallery"),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
