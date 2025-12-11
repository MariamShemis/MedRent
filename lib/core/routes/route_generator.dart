import 'package:flutter/cupertino.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/features/auth/presentation/view/register_screen.dart';
import 'package:med_rent/features/main_layout/main_layout.dart';
import 'package:med_rent/features/onboarding/onboarding_screen.dart';
import 'package:med_rent/features/splash/splash_screen.dart';
import 'package:med_rent/features/start_screen/start_screen.dart';

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
      case AppRoutes.register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
      case AppRoutes.startScreen:
        {
          return CupertinoPageRoute(builder: (context) => StartScreen());
        }
      case AppRoutes.login:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
      
        }
        case AppRoutes.mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());

        }

    

      }
    return null;
  }
}
