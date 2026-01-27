import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/data/cubit/login_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/forget_password_screen.dart';
import 'package:med_rent/features/auth/presentation/view/register_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/features/auth/presentation/widgets/social_category.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => LoginCubit(),

      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.mainLayout);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
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
                    appLocalizations.logIn,
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
                        SizedBox(height: 40.h),
                        Text(
                          appLocalizations.welcomeBack,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontSize: 24.sp),
                        ),
                        SizedBox(height: 40.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAuthTextFormField(
                            controller: emailController,
                            labelText: appLocalizations.email,
                            hintText: appLocalizations.enterYourEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                                AppValidators.validateEmail(context, val),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAuthTextFormField(
                            controller: passwordController,
                            labelText: appLocalizations.password,
                            hintText: '******',
                            isPassword: true,
                            validator: (val) =>
                                AppValidators.validatePassword(context, val),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                    activeColor: Color(0xFF676767),
                                    checkColor: Color(0xFF000000),
                                    side: BorderSide(
                                      color: isChecked
                                          ? Color(0xFF575655)
                                          : Color(0xFF000000),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              appLocalizations.rememberMe,
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
                            ),
                            SizedBox(width: 30.w),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                appLocalizations.forget_password_,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      color: Color(0xFF031B4E),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 43.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is LoginLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<LoginCubit>().loginCubit(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                            child: state is LoginLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(appLocalizations.logIn),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFF676767),
                              ),
                            ),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                appLocalizations.orContinueWith,
                                style: TextStyle(color: Color(0xFF140601)),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFF676767),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialImage(
                              asset: "assets/images/facebook.png",
                              onTap: () {
                                print("Facebook clicked");
                              },
                            ),
                            SizedBox(width: 20.h),
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
                        SizedBox(height: 40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${appLocalizations.dontHaveAnAccount} ",
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
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                appLocalizations.signUp,
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
        },
      ),
    );
  }
}
