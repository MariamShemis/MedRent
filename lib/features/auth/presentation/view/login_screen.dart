import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/forget_password_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/features/auth/presentation/widgets/social_category.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().loginCubit(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
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
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${appLocalizations.loginSuccessfully} : ${appLocalizations.welcome} ${state.loginModel.name}',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.mainLayout,
                        );
                      });
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
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
                        CustomAuthTextFormField(
                          controller: _emailController,
                          labelText: appLocalizations.email,
                          hintText: appLocalizations.enterYourEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              AppValidators.validateEmail(context, val),
                        ),
                        SizedBox(height: 32.h),
                        CustomAuthTextFormField(
                          controller: _passwordController,
                          labelText: appLocalizations.password,
                          hintText: '******',
                          isPassword: true,
                          validator: (val) =>
                              AppValidators.validatePassword(context, val),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 20.w,
                                  child: Checkbox(
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    },
                                    activeColor: const Color(0xFF676767),
                                    checkColor: const Color(0xFF000000),
                                    side: BorderSide(
                                      color: _isChecked
                                          ? const Color(0xFF575655)
                                          : const Color(0xFF000000),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  appLocalizations.rememberMe,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(fontSize: 15.sp),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                appLocalizations.forget_password_,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      fontSize: 15.sp,
                                      color: const Color(0xFF031B4E),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 43.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () => _login(context),
                            child: state is AuthLoading
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
                                color: const Color(0xFF676767),
                              ),
                            ),
                            Padding(
                              padding: REdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                appLocalizations.orContinueWith,
                                style: const TextStyle(
                                  color: Color(0xFF140601),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: const Color(0xFF676767),
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
                              onTap: () => print("Facebook clicked"),
                            ),
                            SizedBox(width: 20.w),
                            SocialImage(
                              asset: "assets/images/google.png",
                              onTap: () => print("Google Sign-In"),
                            ),
                            SizedBox(width: 20.w),
                            SocialImage(
                              asset: 'assets/images/twitter.png',
                              onTap: () => print("Twitter clicked"),
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
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.register,
                                );
                              },
                              child: Text(
                                appLocalizations.signUp,
                                style: Theme.of(context).textTheme.displayLarge!
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF031B4E),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
