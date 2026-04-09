import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/med_rent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51SVpZCJ89TkRuiBxju6u62Gw2JtfGwZKPuWIj8KLFl9WcOhA2rhUaIUG5zEpctXtGLDs75vzngpV14caAAdb0P9w00MU5PUBMX';
  await SessionService.init();
  runApp(BlocProvider(
      create: (_) => AuthCubit(),
      child: const MedRent()));
}
