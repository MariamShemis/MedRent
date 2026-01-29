import 'package:flutter/material.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/med_rent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionService.init();
  runApp(const MedRent());
}
