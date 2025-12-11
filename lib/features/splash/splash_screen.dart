import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double moveOffset = -100.0;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.bgSplash),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(ImageAssets.logo)
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                  duration: 1100.ms,
                  begin: const Offset(0.1, 0.1),
                  end: const Offset(1, 1),
                )
                    .then(delay: 300.ms)
                    .moveX(duration: 600.ms, begin: 0, end: moveOffset),
                Image.asset(ImageAssets.medRent)
                    .animate(
                  delay: 3000.ms,
                  onComplete: (controller) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.pushReplacementNamed(
                          context, AppRoutes.onBoarding);
                    });
                  },
                )
                    .fadeIn(duration: 800.ms)
                    .moveX(duration: 800.ms, begin: -moveOffset, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
