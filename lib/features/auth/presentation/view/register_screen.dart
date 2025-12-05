import 'package:flutter/material.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.signUp , style: Theme.of(context).textTheme.labelLarge,),
        centerTitle: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
