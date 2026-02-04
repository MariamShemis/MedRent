import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/custom_profile_container_item.dart';
import 'package:med_rent/features/main_layout/profile/presentation/widgets/user_image_profile.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String? _userName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final userName = await SessionService.getUserName();
      setState(() {
        _userName = userName ?? 'User';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _userName = 'User';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Profile",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 24.h),
                UserImageProfile(
                  widgetUserImageProfile: CircleAvatar(
                    radius: 40.r,
                    child: Icon(Icons.person, size: 40.sp),
                  ),
                  onTapCamera: _showBottomSheetImage,
                ),
                SizedBox(height: 24.h),
                if (_isLoading)
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )
                else
                  Text(
                    _userName!,
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 24.sp),
                  ),
                SizedBox(height: 16.h),
                Text(
                  "Patient ID: #HE-92031",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.edit_25),
                        SizedBox(width: 5.w),
                        Text("Edit Profile"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 64.h),
                CustomProfileContainerItem(
                  onPressedIconArrow1: () {},
                  onPressedIconArrow2: () {},
                  onPressedIconArrow3: () {
                    Navigator.pushNamed(context, AppRoutes.myRental);
                  },
                  onPressedIconArrow4: () {},
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: _showDialogLogOut,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.logout, color: ColorManager.error),
                      SizedBox(width: 8.w),
                      Text(
                        'Log out',
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(color: ColorManager.error),
                      ),
                    ],
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
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.photo_camera_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    "Take a photo",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    "Choose from gallery",
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to log out'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
