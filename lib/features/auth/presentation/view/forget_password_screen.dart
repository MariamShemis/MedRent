
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/features/auth/presentation/view/verification_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forget Password",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontSize: 20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(ImageAssets.forgetPassword),
                    SizedBox(height: 40.h),
                    Text(
                      'Forget password?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 8.h),
                
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Please enter your email to receive a confirmation code to set a new password',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 12),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          labelText: 'Email',
                          labelStyle: Theme.of(context).textTheme.labelLarge,
                          hintText: 'Enter your email',
                          hintStyle: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(color: Color(0xFF676767)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF000000)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                
                            borderSide: BorderSide(color: Color(0xFF676767)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email required";
                          }
                          if (!value.contains('@')) {
                            return 'Enter a valid email ';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 32.h),
                
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationScreen(),
                              ),
                            );
                          }
                        },
                        child: Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
