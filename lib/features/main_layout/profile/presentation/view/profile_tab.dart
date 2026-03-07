import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
  String? currentImageUrl;
  String userName = "";
  int userId = 0;

  bool isLoadingUserData = false;

  Future<void> _loadUserData() async {
    context.read<ProfileCubit>().getProfileData();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileData())..getProfileData(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: SingleChildScrollView(
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
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (isLoadingUserData || state is ProfileLoading) {
                        return Column(
                          children: [
                            UserImageProfile(
                              widgetUserImageProfile: CircleAvatar(
                                radius: 46.r,
                                backgroundImage:
                                    currentImageUrl != null &&
                                        currentImageUrl!.isNotEmpty
                                    ? NetworkImage(
                                        "$currentImageUrl?t=${DateTime.now().millisecondsSinceEpoch}",
                                      )
                                    : null,
                                child:
                                    currentImageUrl == null ||
                                        currentImageUrl!.isEmpty
                                    ? Icon(Icons.person, size: 40.sp)
                                    : null,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      }
                      if (state is ProfileSuccess) {
                        currentImageUrl = state.profileModel.imageUrl;
                        userName = state.profileModel.name;
                        userId = state.profileModel.userId;
                      }
                      return Column(
                        children: [
                          UserImageProfile(
                            widgetUserImageProfile: CircleAvatar(
                              radius: 46.r,
                              backgroundImage:
                                  currentImageUrl != null &&
                                      currentImageUrl!.isNotEmpty
                                  ? NetworkImage(
                                      "$currentImageUrl?t=${DateTime.now().millisecondsSinceEpoch}",
                                    )
                                  : null,
                              child:
                                  currentImageUrl == null ||
                                      currentImageUrl!.isEmpty
                                  ? Icon(Icons.person, size: 40.sp)
                                  : null,
                            ),
                          ),
                          SizedBox(height: 18.h),
                          Text(
                            userName,
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge!.copyWith(fontSize: 24.sp),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Patient ID : #HE-$userId",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      );
                    },
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
                          Navigator.pushNamed(context, AppRoutes.myRental);
                        },
                        onPressedIconPersonalInformation: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.personalInformation,
                          ).then((value) {
                            if (value == true) {
                              context.read<ProfileCubit>().getProfileData();
                            }
                          });
                        },
                        onPressedIconContactUs: () {
                          Navigator.pushNamed(context, AppRoutes.contactUs);
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
                        Icon(Iconsax.logout, color: ColorManager.red, size: 26),
                        SizedBox(width: 8.w),
                        Text(
                          appLocalizations.log_out,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: ColorManager.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogLogOut() {
    final appLocalizations = AppLocalizations.of(context)!;
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
              onPressed: () => Navigator.pop(context),
              child: Text(appLocalizations.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.startScreen,
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
