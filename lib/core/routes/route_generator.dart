import 'package:flutter/cupertino.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/onboarding/onboarding_screen.dart';
import 'package:med_rent/features/splash/splash_screen.dart';

abstract class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        {
          return CupertinoPageRoute(builder: (context) => SplashScreen());
        }
      case AppRoutes.onBoarding:
        {
          return CupertinoPageRoute(builder: (context) => OnboardingScreen());
        }
    }
    return null;
  }
}
