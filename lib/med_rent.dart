import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/routes/route_generator.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/theme_manager.dart';

class MedRent extends StatelessWidget {
  const MedRent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute:RoutesManager.router,
        initialRoute:AppRoutes.splash,
        theme: ThemeManager.lightTheme,
      ),

    );
  }
}
