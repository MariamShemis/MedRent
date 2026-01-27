import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/features/auth/presentation/widgets/social_category.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: false,
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              appLocalizations.signUp,
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontSize: 20.sp),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 30.h),
                  Text(
                    '${appLocalizations.welcome}',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 24.sp),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: emailController,
                      labelText: appLocalizations.email,
                      hintText: appLocalizations.enterYourEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => AppValidators.validateEmail(context, val),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: nameController,
                      labelText: appLocalizations.name,
                      hintText: appLocalizations.enterYourEmail,
                      validator: (val) => AppValidators.validateUsername(context, val),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: passwordController,
                      labelText: appLocalizations.password,
                      hintText: '******',
                      isPassword: true,
                      validator: (val) => AppValidators.validatePassword(context, val),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: confirmPasswordController,
                      labelText: appLocalizations.confirmPassword,
                      hintText: '******',
                      isPassword: true,
                      validator: (val) => AppValidators.validateConfirmPassword(context, val , passwordController.text),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: Text(appLocalizations.signUp),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Color(0xFF676767)),
                      ),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          appLocalizations.orContinueWith,
                          style: TextStyle(color: Color(0xFF140601)),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 1, color: Color(0xFF676767)),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialImage(
                        asset: "assets/images/facebook.png",
                        onTap: () {
                          print("Facebook clicked");
                        },
                      ),
                      SizedBox(width: 20.w),
                      SocialImage(
                        asset: "assets/images/google.png",
                        onTap: () {
                          print("Google Sign-In ");
                        },
                      ),
                      SizedBox(width: 20.w),
                      SocialImage(
                        asset: 'assets/images/twitter.png',
                        onTap: () {
                          print("Twitter clicked");
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalizations.alreadyHaveAccount,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(fontSize: 14.sp),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          appLocalizations.logIn,
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(
                                fontSize: 14.sp,
                                color: Color(0xFF031B4E),
                              ),
                        ),
                      ),
                    ],
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
