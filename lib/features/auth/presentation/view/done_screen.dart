import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class DoneScreen extends StatefulWidget {
  const DoneScreen({super.key});

  @override
  State<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  late Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(seconds: 1), () {
      Navigator.of(context).pop;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: REdgeInsets.all(24.0),
        child: SizedBox(
          height: 289,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.done, width: 90.w, height: 90.h),
              SizedBox(height: 20.h),
              Text(
                appLocalizations.the_password_has_been_changed,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
