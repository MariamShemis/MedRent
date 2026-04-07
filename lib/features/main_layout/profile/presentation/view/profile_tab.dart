import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/dashboard_doctor/presentation/view/dashboard_doctor.dart';
import 'package:med_rent/features/language/data/cubit/app_localization_cubit.dart';
import 'package:med_rent/features/main_layout/profile/data/cubit/profile_cubit.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_menu_item.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/custom_profile_container_item.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/user_image_profile.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? profileImageUrl;
  String userName = "";
  int userId = 0;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return SizedBox(
                    height: 620.h,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if(state is ProfileError){
                  return Text(state.message);
                }
                if (state is ProfileSuccess) {
                  profileImageUrl = state.profileModel.imageUrl;
                  userName = state.profileModel.name;
                  userId = state.profileModel.userId;
                  final role = state.role ?? 'Patient';
                  String displayId = '';
                  switch (role) {
                    case 'Admin':
                      displayId = "${appLocalizations.adminID} : #HE-$userId";
                      break;
                    case 'Doctor':
                      displayId = "${appLocalizations.doctorID} : #HE-$userId";
                      break;
                    case 'EquipmentOwner':
                      displayId = "${appLocalizations.ownerID} : #HE-$userId";
                      break;
                    default:
                      displayId = "${appLocalizations.patientID} : #HE-$userId";
                  }
                  List<ProfileMenuItem> menuItems = [];
                  menuItems.add(
                    ProfileMenuItem(
                      icon: Iconsax.user_edit4,
                      text: appLocalizations.personalInformation,
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.personalInformation,
                      ),
                    ),
                  );
                  if (role == 'Admin') {
                    menuItems.addAll([
                      ProfileMenuItem(
                        icon: Icons.dashboard_outlined,
                        text: appLocalizations.dashboard,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.dashboardAdmin);
                        },
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.calendar_1,
                        text: appLocalizations.booking,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.devices_14,
                        text: appLocalizations.devices,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.health,
                        text: appLocalizations.doctor,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.profile_2user4,
                        text: appLocalizations.users,
                        onPressed: () {},
                      ),
                    ]);
                  } else if (role == 'EquipmentOwner') {
                    menuItems.addAll([
                      ProfileMenuItem(
                        icon: Icons.dashboard_outlined,
                        text: appLocalizations.dashboard,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.dashboardEOwner);
                        },
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.calendar_1,
                        text: appLocalizations.booking,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.notification,
                        text: appLocalizations.notificationSettings,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationSetting,
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.devices_14,
                        text: appLocalizations.my_devices,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Icons.add_circle_outline,
                        text: appLocalizations.add_a_Device,
                        onPressed: () {},
                      ),
                    ]);
                  } else if (role == 'Doctor') {
                    menuItems.addAll([
                      ProfileMenuItem(
                        icon: Icons.dashboard_outlined,
                        text: appLocalizations.dashboard,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.dashboardDoctor);
                        },
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.calendar_1,
                        text: appLocalizations.booking,
                        onPressed: () {},
                      ),
                      ProfileMenuItem(
                        icon: Iconsax.notification,
                        text: appLocalizations.notificationSettings,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationSetting,
                          );
                        },
                      ),
                    ]);
                  } else {
                    menuItems.add(
                      ProfileMenuItem(
                        icon: Iconsax.calendar_1,
                        text: appLocalizations.contactUs,
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.contactUs),
                      ),
                    );
                    menuItems.add(
                      ProfileMenuItem(
                        icon: Iconsax.box_search,
                        text: appLocalizations.myRentals,
                        onPressed: () =>
                            Navigator.pushNamed(context, AppRoutes.myRental),
                      ),
                    );
                    menuItems.add(
                      ProfileMenuItem(
                        icon: Iconsax.notification,
                        text: appLocalizations.notificationSettings,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationSetting,
                          );
                        },
                      ),
                    );
                  }
                  final isArabic =
                      context.read<AppLocalizationCubit>().state.languageCode ==
                      'ar';
                  menuItems.add(
                    ProfileMenuItem(
                      icon: Icons.language_outlined,
                      text: appLocalizations.language,
                      isLanguage: true,
                      textLanguage: isArabic ? "العربية" : "English",
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRoutes.languageProfile,
                      ),
                    ),
                  );
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 50.w),
                          Text(
                            appLocalizations.profile,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge!
                                .copyWith(fontSize: 24.sp),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.myNotification,
                              );
                            },
                            icon: Icon(
                              Iconsax.notification4,
                              color: Theme.of(context).primaryColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      UserImageProfile(
                        widgetUserImageProfile: CircleAvatar(
                          radius: 46.r,
                          backgroundImage:
                              (profileImageUrl != null &&
                                  profileImageUrl!.isNotEmpty)
                              ? NetworkImage(profileImageUrl!)
                              : null,
                          child:
                              (profileImageUrl == null ||
                                  profileImageUrl!.isEmpty)
                              ? Icon(
                                  Icons.person,
                                  size: 40.sp,
                                  color: Colors.white,
                                )
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
                        displayId,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 200.w,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.personalInformation,
                            ).then((value) {
                              if (value == true) {
                                context.read<ProfileCubit>().getProfileData();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.darkBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
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
                              Text(
                                appLocalizations.editProfile,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomProfileContainerItem(items: menuItems),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () => _showDialogLogOut(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.logout,
                              color: ColorManager.red,
                              size: 26.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              appLocalizations.log_out,
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(color: ColorManager.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100.h,),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogLogOut(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(appLocalizations.log_out),
        content: Text(appLocalizations.are_you_sure_you_want_to_log_out),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(appLocalizations.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.startScreen,
              (route) => false,
            ),
            child: Text(appLocalizations.ok),
          ),
        ],
      ),
    );
  }
}
