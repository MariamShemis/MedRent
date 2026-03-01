import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/constants/color_manager.dart';
import 'package:med_rent/core/routes/app_routes.dart';
import 'package:med_rent/features/auth/data/cubit/auth_cubit.dart';
import 'package:med_rent/features/auth/presentation/widgets/pin_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class VerifyRegister extends StatefulWidget {
  const VerifyRegister({super.key});

  @override
  State<VerifyRegister> createState() => _VerifyRegisterState();
}

class _VerifyRegisterState extends State<VerifyRegister> {
  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final TextEditingController pin3Controller = TextEditingController();
  final TextEditingController pin4Controller = TextEditingController();
  final TextEditingController pin5Controller = TextEditingController();
  final TextEditingController pin6Controller = TextEditingController();
  final FocusNode pin1Focus = FocusNode();
  final FocusNode pin2Focus = FocusNode();
  final FocusNode pin3Focus = FocusNode();
  final FocusNode pin4Focus = FocusNode();
  final FocusNode pin5Focus = FocusNode();
  final FocusNode pin6Focus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pin1Controller.dispose();
    pin2Controller.dispose();
    pin3Controller.dispose();
    pin4Controller.dispose();
    pin5Controller.dispose();
    pin6Controller.dispose();
    pin1Focus.dispose();
    pin2Focus.dispose();
    pin3Focus.dispose();
    pin4Focus.dispose();
    pin5Focus.dispose();
    pin6Focus.dispose();
    super.dispose();
  }

  String _collectOtp() {
    return pin1Controller.text +
        pin2Controller.text +
        pin3Controller.text +
        pin4Controller.text +
        pin5Controller.text +
        pin6Controller.text;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "OTP",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontSize: 20.sp),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthVerifyRegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: TextStyle(color: ColorManager.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: TextStyle(color: ColorManager.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 70),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      appLocalizations.enter_the_digit_OTP_sent_to_your_email,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PinField(
                          isSquare: true,
                          controller: pin1Controller,
                          focusNode: pin1Focus,
                          nextFocusNode: pin2Focus,
                        ),
                        SizedBox(width: 10.w),
                        PinField(
                          isSquare: true,
                          controller: pin2Controller,
                          focusNode: pin2Focus,
                          nextFocusNode: pin3Focus,
                        ),
                        SizedBox(width: 10.w),
                        PinField(
                          isSquare: true,
                          controller: pin3Controller,
                          focusNode: pin3Focus,
                          nextFocusNode: pin4Focus,
                        ),
                        SizedBox(width: 10.w),
                        PinField(
                          isSquare: true,
                          controller: pin4Controller,
                          focusNode: pin4Focus,
                          nextFocusNode: pin5Focus,
                        ),
                        SizedBox(width: 10.w),
                        PinField(
                          isSquare: true,
                          controller: pin5Controller,
                          focusNode: pin5Focus,
                          nextFocusNode: pin6Focus,
                        ),
                        SizedBox(width: 10.w),
                        PinField(
                          isSquare: true,
                          controller: pin6Controller,
                          focusNode: pin6Focus,
                          nextFocusNode: null,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      appLocalizations.didnt_get_the_OTP,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () {
                        context.read<AuthCubit>().registerCubit(
                          email: context.read<AuthCubit>().email!,
                          name: context.read<AuthCubit>().name!,
                          password: context.read<AuthCubit>().password!,
                          phone: context.read<AuthCubit>().phone!,
                          context: context,
                        );
                      },
                      child: Text(
                        appLocalizations.resend_OTP,
                        style: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(color: ColorManager.secondary),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                final otp = _collectOtp();
                                context.read<AuthCubit>().verifyRegisterCubit(
                                  code: otp,
                                  context: context,
                                );
                              },
                              child: Text(appLocalizations.confirm),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
