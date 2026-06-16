import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/admin_add_doctor/data/cubit/add_doctor_cubit.dart';
import 'package:med_rent/features/admin_add_doctor/data/cubit/add_doctor_state.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_model.dart';
import 'package:med_rent/features/admin_add_doctor/presentation/widgets/card_add_image.dart';
import 'package:med_rent/features/admin_add_doctor/presentation/widgets/custom_add_text_form_field.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/personal_profile_gender_text.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class AdminAddDoctor extends StatefulWidget {
  const AdminAddDoctor({super.key});

  @override
  State<AdminAddDoctor> createState() => _AdminAddDoctorState();
}

class _AdminAddDoctorState extends State<AdminAddDoctor> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController experienceYearController;
  late TextEditingController emailController;
  late TextEditingController specializationController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController priceController;

  File? selectedImage;
  int? selectedHospitalId;
  int? selectedDepartmentId;
  String selectedHospitalName = "";
  String selectedDepartmentName = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    experienceYearController = TextEditingController();
    emailController = TextEditingController();
    specializationController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    priceController = TextEditingController();
    context.read<AddDoctorCubit>().getHospitals();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    experienceYearController.dispose();
    emailController.dispose();
    specializationController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: Text(appLocalizations.addDoctor),
      ),
      body: BlocConsumer<AddDoctorCubit, AddDoctorState>(
        listener: (context, state) {
          if (state is HospitalsLoaded && state.hospitals.isNotEmpty) {
            setState(() {
              selectedHospitalName = state.hospitals.first.name;
              selectedHospitalId = state.hospitals.first.hospitalId;
              selectedDepartmentName = "";
            });
            context.read<AddDoctorCubit>().getDepartments(state.hospitals.first.hospitalId);
          }

          if (state is DepartmentsLoaded) {
            setState(() {
              if (state.departments.isNotEmpty) {
                selectedDepartmentName = state.departments.first.name;
                selectedDepartmentId = state.departments.first.departmentId;
              } else {
                selectedDepartmentName = "";
                selectedDepartmentId = null;
              }
            });
          }
          if (state is AddDoctorSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
          if (state is AddDoctorError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddDoctorCubit>();
          return SafeArea(
            child: SingleChildScrollView(
              padding: REdgeInsets.all(12),
              child: Column(
                children: [
                  CardAddImage(
                    text: appLocalizations.doctorImage,
                    onTap: _showBottomSheetImage,
                    image: selectedImage,
                  ),
                  SizedBox(height: 16.h),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    color: ColorManager.white,
                    elevation: 5,
                    child: Padding(
                      padding: REdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.doctorInformation,
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(fontSize: 18),
                          ),
                          SizedBox(height: 18.h),
                          CustomAddTextFormField(
                            controller: nameController,
                            hintText: appLocalizations.enter_name_of_doctor,
                            keyboardType: TextInputType.text,
                            labelName: appLocalizations.name,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: emailController,
                            hintText: appLocalizations.enter_email,
                            keyboardType: TextInputType.emailAddress,
                            labelName: appLocalizations.email,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: passwordController,
                            hintText: appLocalizations.enter_password,
                            keyboardType: TextInputType.text,
                            labelName: appLocalizations.password,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: experienceYearController,
                            hintText: appLocalizations.enter_experience_year,
                            keyboardType: TextInputType.number,
                            labelName: appLocalizations.experienceYear,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: specializationController,
                            hintText: appLocalizations.enter_specialization,
                            keyboardType: TextInputType.text,
                            labelName: appLocalizations.specialization,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            appLocalizations.hospital,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium!.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 8.h),
                          if (cubit.hospitals.isNotEmpty)
                            PersonalProfileGenderText(
                              isGender: false,
                              selectedLabel: selectedHospitalName,
                              menuItems: cubit.hospitals.map((e) => e.name).toList(),
                              onChange: (value) {
                                if (value != null && value != selectedHospitalName) {
                                  final selected = cubit.hospitals.firstWhere(
                                        (e) => e.name == value,
                                  );
                                  setState(() {
                                    selectedHospitalName = value;
                                    selectedHospitalId = selected.hospitalId;
                                    selectedDepartmentName = "";
                                    selectedDepartmentId = null;
                                  });
                                  cubit.getDepartments(selected.hospitalId);
                                }
                              },
                            ),
                          SizedBox(height: 12.h),
                          Text(
                            appLocalizations.department,
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium!.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 8.h),
                          if (cubit.departments.isNotEmpty)
                            PersonalProfileGenderText(
                              isGender: false,
                              selectedLabel: selectedDepartmentName,
                              menuItems: cubit.departments.map((e) => e.name).toList(),
                              onChange: (value) {
                                if (value != null) {
                                  final selected = cubit.departments.firstWhere(
                                        (e) => e.name == value,
                                  );
                                  setState(() {
                                    selectedDepartmentName = value;
                                    selectedDepartmentId = selected.departmentId;
                                  });
                                }
                              },
                            )
                          else
                            Container(
                              width: double.infinity,
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                border: Border.all(color: ColorManager.lightGrey),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Text(
                                state is AddDoctorLoading ? "Loading..." : "No Departments Available",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: priceController,
                            hintText:
                            appLocalizations.enter_price_of_consutation,
                            keyboardType: TextInputType.number,
                            labelName: appLocalizations.price,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: startTimeController,
                            hintText: appLocalizations.enter_start_time,
                            keyboardType: TextInputType.text,
                            labelName: appLocalizations.startTime,
                          ),
                          SizedBox(height: 12.h),
                          CustomAddTextFormField(
                            controller: endTimeController,
                            hintText: appLocalizations.enter_end_time,
                            keyboardType: TextInputType.text,
                            labelName: appLocalizations.end_Time,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: (state is AddDoctorLoading)
                          ? null
                          : () {
                        if (_validateFields()) {
                          final doctor = AddDoctorModel(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            specialization: specializationController.text,
                            experienceYears: int.parse(
                              experienceYearController.text,
                            ),
                            consultationPrice: double.parse(
                              priceController.text,
                            ),
                            startTime: startTimeController.text,
                            endTime: endTimeController.text,
                            departmentId: selectedDepartmentId!,
                            image: selectedImage!.path,
                          );
                          cubit.addDoctor(doctor);
                        }
                      },
                      child: state is AddDoctorLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(appLocalizations.addDoctor),
                          SizedBox(width: 10.w),
                          Icon(Icons.upload, color: ColorManager.white),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  bool _validateFields() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        selectedDepartmentId == null ||
        selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields and select a doctor image",
          ),
        ),
      );
      return false;
    }
    return true;
  }

  void _showBottomSheetImage() {
    final appLocalizations = AppLocalizations.of(context)!;
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
              onTap: () => _pickImage(ImageSource.camera),
              child: Row(
                children: [
                  const Icon(Icons.photo_camera_outlined),
                  SizedBox(width: 10.w),
                  Text(appLocalizations.take_a_photo),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () => _pickImage(ImageSource.gallery),
              child: Row(
                children: [
                  const Icon(Icons.photo_library_outlined),
                  SizedBox(width: 10.w),
                  Text(appLocalizations.choose_from_gallery),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      setState(() => selectedImage = File(picked.path));
      if (mounted) Navigator.pop(context);
    }
  }
}