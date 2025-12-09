import 'package:flutter/material.dart';
import 'package:med_rent/features/auth/presentation/view/done_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newpasswordController.dispose();
    confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Create new password",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontSize: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text(
                    'New Password',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please write your new password',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: newpasswordController,
                      labelText: 'New Password',
                      hintText: '******',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: '******',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password required";
                        }
                        if (value != newpasswordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DoneScreen();
                            },
                          );
                        }
                      },
                      child: Text("Confirm"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
