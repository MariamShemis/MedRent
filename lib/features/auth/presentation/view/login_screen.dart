import 'package:flutter/material.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.logIn, style: Theme.of(context).textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
