import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';

class UserImageProfile extends StatelessWidget {
  const UserImageProfile({
    super.key,
    required this.widgetUserImageProfile,
    required this.onTapCamera,
  });

  final Widget widgetUserImageProfile;
  final VoidCallback onTapCamera;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorManager.darkBlue, width: 3.w),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: widgetUserImageProfile,
        ),
        GestureDetector(
          onTap: onTapCamera,
          child: Container(
            padding: REdgeInsets.all(5),
            margin: REdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: ColorManager.darkBlue,
            ),
            child: Icon(Icons.camera_alt_outlined, color: ColorManager.white, size: 23),
          ),
        ),
      ],
    );
  }
}
