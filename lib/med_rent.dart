import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/routes/route_generator.dart';
import 'package:med_rent/l10n/app_localizations.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme_manager.dart';

class MedRent extends StatelessWidget {
  const MedRent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(385, 820),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute:RoutesManager.router,
        initialRoute:AppRoutes.splash,
        theme: ThemeManager.lightTheme,
        locale: Locale("ar"),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),

    );
  }
}
