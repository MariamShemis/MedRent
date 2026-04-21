import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/devices_add_owner/data/cubit/owner_add_devices_cubit.dart';
import 'package:med_rent/features/devices_add_owner/data/data_source/add_device_owner_service.dart';
import 'package:med_rent/features/devices_add_owner/presentation/widget/custom_add_devices_text_field_owner.dart';
import 'package:med_rent/features/devices_add_owner/presentation/widget/devices_owner_image_card.dart';

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
    return BlocProvider(
      create: (context) => OwnerAddDevicesCubit(AddDeviceOwnerService(ApiClient())),
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
              title: const Text(
                " Add New Devices",
                style: TextStyle(
                  color: ColorManager.darkBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          body: 
          BlocConsumer<OwnerAddDevicesCubit, OwnerAddDevicesState>(
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
                    state.message.isEmpty
                        ? "An error occurred"
                        : state.message,
                  ),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3), // عشان يلحق يظهر
                ),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<OwnerAddDevicesCubit>();
              return SafeArea(
                            top: false,
                            child: SingleChildScrollView(
                              padding: REdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // قسم صورة الجهاز
                                  DevicesOwnerImageCard(
                                    text: "Device Image",
                                    onTap: () => _showBottomSheetImage(context, cubit),
                                  ),
              
                                  // إشعار بسيط لو الصورة تم اختيارها
                                  if (cubit.pickedImagePath != null)
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal: 8.w,
                                      ),
                                      child: Text(
                                        "Image selected: ${cubit.pickedImagePath!.split('/').last}",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 20.h),
              
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
                                            "Device Information",
                                            style: Theme.of(context).textTheme.titleMedium!
                                                .copyWith(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          SizedBox(height: 20.h),
              
                                          CustomAddDevicesTextFieldOwner(
                                            controller: nameController,
                                            hintText: "Enter name of device",
                                            keyboardType: TextInputType.text,
                                            labelName: "Name",
                                          ),
                                          SizedBox(height: 12.h),
              
                                          CustomAddDevicesTextFieldOwner(
                                            controller: priceController,
                                            hintText: "Enter price of device",
                                            keyboardType: TextInputType.number,
                                            labelName: "Price",
                                          ),
                                          SizedBox(height: 12.h),
              
                                          CustomAddDevicesTextFieldOwner(
                                            controller: descriptionController,
                                            hintText:
                                                "Enter a detailed description of the device...",
                                            keyboardType: TextInputType.multiline,
                                            labelName: "Description",
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
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF031B4E,
                                            ), // لون Figma
                                            minimumSize: Size(double.infinity, 50.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                          ),
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
                                              const Text(
                                                "Add Device",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
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
                cubit.pickImageOwner(sources: ImageSource.camera); // اختيار كاميرا
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
