import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/l10n/app_localizations.dart';

import '../../core/constants/color_manager.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(ImageAssets.medRent),
              SizedBox(height: 32.h),
              Image.asset(ImageAssets.startScreen),
              SizedBox(height: 40.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  children: <TextSpan>[
                    TextSpan(text: '${appLocalizations.welcomeTo} '),
                    TextSpan(
                      text: 'Med',
                      style: TextStyle(color: ColorManager.darkBlue),
                    ),
                    TextSpan(
                      text: 'Rent',
                      style: TextStyle(color: ColorManager.secondary),
                    ),
                    const TextSpan(text: ' !'),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                appLocalizations.logInToYourExistingAccountOrCreateANewOne,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                }, child: Text(appLocalizations.logIn)),
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.register);
                }, child: Text(appLocalizations.signUp)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
