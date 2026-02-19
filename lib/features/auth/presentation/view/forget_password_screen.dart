import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/data/cubit/forget_password_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/verification_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

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
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
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
                appLocalizations.forgetPassword,
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
              child: Center(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is ForgotPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen( email: emailController.text.trim(),),
                          ),
                        );
                      }

                      if (state is ForgotPasswordFailure) {
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
                        children: [
                          SizedBox(height: 40.h),
                          Image.asset(ImageAssets.forgetPassword),
                          SizedBox(height: 40.h),
                          Text(
                            appLocalizations.forget_password_,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 8.h),

                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              appLocalizations
                                  .pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 32.h),
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
                            child: ElevatedButton(
                              onPressed: state is ForgotPasswordLoading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        context
                                            .read<ForgetPasswordCubit>()
                                            .sendOtp(
                                              email: emailController.text
                                                  .trim(),
                                            );
                                      }
                                    },
                              child: state is ForgotPasswordLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(appLocalizations.continueBtn),
                            ),
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
      ),
    );
  }
}
