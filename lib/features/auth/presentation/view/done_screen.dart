import 'dart:async';

import 'package:flutter/material.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';

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
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 289,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.done, width: 90, height: 90),
              const SizedBox(height: 20),
              Text(
                'The password has been changed.',
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
