import 'package:flutter/material.dart';
import 'package:med_rent/core/constants/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(ImageAssets.bgSplash) , fit: BoxFit.fill),
        ),
        child: Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.logo),
              Image.asset(ImageAssets.medRent),
            ],
          ),
        ),
      ),
    );
  }
}
