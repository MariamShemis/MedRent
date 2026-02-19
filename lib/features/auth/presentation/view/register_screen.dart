import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/features/auth/presentation/widgets/social_category.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(appLocalizations.passwords_dont_match),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthCubit>().registerCubit(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
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
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Text(
                          appLocalizations.welcome,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontSize: 24.sp),
                        ),
                        SizedBox(height: 30.h),
                        CustomAuthTextFormField(
                          controller: _nameController,
                          labelText: appLocalizations.name,
                          hintText: appLocalizations.enterYourName,
                          validator: (val) =>
                              AppValidators.validateUsername(context, val),
                        ),
                        SizedBox(height: 22.h),
                        CustomAuthTextFormField(
                          controller: _emailController,
                          labelText: appLocalizations.email,
                          hintText: appLocalizations.enterYourEmail,
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                              AppValidators.validateEmail(context, val),
                        ),
                        SizedBox(height: 22.h),
                        CustomAuthTextFormField(
                          controller: _phoneController,
                          labelText: appLocalizations.phoneNumber,
                          hintText: appLocalizations.enter_Your_phone_number,
                          keyboardType: TextInputType.phone,
                          validator: (val) =>
                              AppValidators.validatePhoneNumber(context, val),
                        ),
                        SizedBox(height: 22.h),
                        CustomAuthTextFormField(
                          controller: _passwordController,
                          labelText: appLocalizations.password,
                          hintText: '******',
                          isPassword: true,
                          validator: (val) =>
                              AppValidators.validatePassword(context, val),
                        ),
                        SizedBox(height: 22.h),
                        CustomAuthTextFormField(
                          controller: _confirmPasswordController,
                          labelText: appLocalizations.confirmPassword,
                          hintText: '******',
                          isPassword: true,
                          validator: (val) =>
                              AppValidators.validateConfirmPassword(
                                context,
                                val,
                                _passwordController.text,
                              ),
                        ),
                        SizedBox(height: 28.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () => _register(context),
                            child: state is AuthLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(appLocalizations.signUp),
                          ),
                        ),
                        SizedBox(height: 30.h),
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
                        SizedBox(height: 30.h),
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
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: Text(
                                appLocalizations.logIn,
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
