import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/user_image_profile.dart';
import 'package:med_rent/features/update_profile/data/cubit/update_profile_cubit.dart';
import 'package:med_rent/features/update_profile/data/cubit/update_profile_state.dart';
import 'package:med_rent/features/update_profile/data/models/update_profile_model.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/brith_date_field.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/custom_profile_text_form_field.dart';
import 'package:med_rent/features/update_profile/presentation/widgets/personal_profile_gender_text.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late TextEditingController nameController;
  late TextEditingController birthController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  String? selectedGender = "Male";
  File? selectedImage;
  String? profileImageUrl;
  bool isLoading = true;

  String _resolveImageUrl(String path) {
    if (path.startsWith('http')) return path;
    String cleanPath = path.startsWith('/') ? path : '/$path';
    return "${ApiConstants.baseImageUrl}$cleanPath";
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    birthController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final cubit = context.read<UpdateProfileCubit>();
    final profile = await cubit.getProfile(context);
    if (profile != null) {
      nameController.text = profile.name;
      phoneController.text = profile.phone;
      emailController.text = profile.email;
      birthController.text = profile.dateOfBirth.split('T')[0];
      selectedGender = profile.gender?.isNotEmpty == true
          ? profile.gender
          : selectedGender;

      if (profile.imageUrl != null && profile.imageUrl!.isNotEmpty) {
        setState(() {
          profileImageUrl = _resolveImageUrl(profile.imageUrl!);
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      selectedImage = File(pickedFile.path);
    });
    Navigator.pop(context);
    context.read<UpdateProfileCubit>().uploadImage(selectedImage!, context);
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(appLocalizations.personalInformation)),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(appLocalizations.personalInformation),
      ),
      body: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          }
          if (state is UpdateProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          if (state is UpdateProfileImageUploaded) {
            setState(() {
              profileImageUrl = _resolveImageUrl(state.imageUrl);
            });
          }
        },
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: UserImageProfile(
                    widgetUserImageProfile: CircleAvatar(
                      key: ValueKey(profileImageUrl),
                      radius: 46.r,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : (profileImageUrl != null &&
                                profileImageUrl!.isNotEmpty)
                          ? NetworkImage(profileImageUrl!)
                          : null,
                      child:
                          selectedImage == null &&
                              (profileImageUrl == null ||
                                  profileImageUrl!.isEmpty)
                          ? Icon(Icons.person, size: 40.sp)
                          : null,
                    ),
                    onTapCamera: _showBottomSheetImage,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomProfileTextFormField(
                  controller: nameController,
                  hintText: appLocalizations.enterYourName,
                  labelName: appLocalizations.name, keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20.h),
                BirthDateField(controller: birthController),
                SizedBox(height: 20.h),
                Text(
                  appLocalizations.gender,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.darkBlue,
                  ),
                ),
                SizedBox(height: 8.h),
                PersonalProfileGenderText(
                  selectedLabel: selectedGender ?? appLocalizations.male,
                  menuItems: [appLocalizations.male, appLocalizations.female],
                  onChange: (value) => setState(
                    () => selectedGender = value ?? appLocalizations.male,
                  ),
                ),
                SizedBox(height: 20.h),
                CustomProfileTextFormField(
                  labelName: appLocalizations.phone,
                  controller: phoneController,
                  hintText: appLocalizations.enter_Your_phone_number,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20.h),
                CustomProfileTextFormField(
                  labelName: appLocalizations.email,
                  controller: emailController,
                  hintText: appLocalizations.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
                    builder: (context, state) {
                      if (state is UpdateProfileLoading)
                        return const Center(child: CircularProgressIndicator());
                      return ElevatedButton(
                        onPressed: () {
                          context.read<UpdateProfileCubit>().updateProfile(
                            UpdateProfileRequest(
                              name: nameController.text,
                              dateOfBirth: birthController.text,
                              gender: selectedGender ?? appLocalizations.male,
                              phone: phoneController.text,
                              email: emailController.text,
                            ),
                            context,
                          );
                        },
                        child: Text(appLocalizations.saveChanges),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
