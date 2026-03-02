import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/language/data/cubit/app_localization_cubit.dart';
import 'package:med_rent/features/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:med_rent/features/main_layout/profile/data/data_sources/profile_data.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/custom_profile_container_item.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/user_image_profile.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final ImagePicker _picker = ImagePicker();
  Future<void> pickAndUploadImage(
    ImageSource source,
    BuildContext cubitContext,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (image != null && mounted) {
       Navigator.pop(context);
      if (cubitContext.mounted) {
       
        cubitContext.read<ProfileCubit>().updateProfileImage(image.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileData())..getProfileData(),
      child: Builder(
        builder: (context) {
              AppLocalizations appLocalizations = AppLocalizations.of(context)!;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: REdgeInsets.all(16.0),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProfileError) {
                      return Center(child: Text(state.message));
                    } else if (state is ProfileSuccess) {
                      final user = state.profileModel;
          
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              appLocalizations.profile,
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                            ),
                            SizedBox(height: 15.h),
                            Center(
                              child: UserImageProfile(
                                widgetUserImageProfile: CircleAvatar(
                                  radius: 40.r,
                                  backgroundImage: user.imageUrl.isNotEmpty
                                      ? NetworkImage(
                                          '${ApiConstants.baseImageUrl}${user.imageUrl}?t=${DateTime.now().millisecondsSinceEpoch}',
                                        )
                                      : null,
                                  child: user.imageUrl.isEmpty
                                      ? Icon(Icons.person, size: 40.sp)
                                      : null,
                                ),
onTapCamera: () => _showBottomSheetImage(context),                              ),
                            ),
                            SizedBox(height: 18.h),
          
                            Text(
                              user.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.displayLarge!.copyWith(fontSize: 24.sp),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              "${appLocalizations.patientID} : #HE-${user.userId}",
                              textAlign: TextAlign.center,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: 200,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.darkBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.edit_2,
                                      size: 20.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(appLocalizations.editProfile),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            BlocBuilder<AppLocalizationCubit, Locale>(
                              builder: (context, locale) {
                                final isArabic = locale.languageCode == 'ar';
                                return CustomProfileContainerItem(
                                  onPressedNotification: () {},
                                  onPressedIconMyRental: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.myRental,
                                    );
                                  },
                                  onPressedIconPersonalInformation: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.personalInformation,
                                    ).then((_) {
                                      context.read<ProfileCubit>().getProfileData();
                                    });
                                  },
                                  onPressedIconContactUs: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.contactUs,
                                    );
                                  },
                                  textLanguage: isArabic ? "العربية" : "English",
                                  onPressedLanguage: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.languageProfile,
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: _showDialogLogOut,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.logout,
                                    color: ColorManager.red,
                                    size: 26,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    appLocalizations.log_out,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: ColorManager.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
          
                    return const SizedBox();
                  },
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  void _showBottomSheetImage(BuildContext cubitContext ) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: REdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                pickAndUploadImage(ImageSource.camera, cubitContext);
              },
              child: Row(
                children: [
                  Icon(Icons.photo_camera_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    appLocalizations.take_a_photo,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                pickAndUploadImage(ImageSource.gallery, cubitContext);
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    appLocalizations.choose_from_gallery,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  void _showDialogLogOut() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16.r),
          ),
          title: Text(appLocalizations.log_out),
          content: Text(appLocalizations.are_you_sure_you_want_to_log_out),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(appLocalizations.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: Text(appLocalizations.ok),
            ),
          ],
        );
      },
    );
  }
}
