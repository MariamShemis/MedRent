import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/auth/data/cubit/verification_code_cubit.dart';
import 'package:med_rent/features/auth/data/cubit/forget_password_cubit.dart'; // تأكدي من هذا المسار
import 'package:med_rent/features/auth/data/data_sources/auth_remote_data.dart';
import 'package:med_rent/features/auth/presentation/view/new_password_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/pin_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController pin1Controller = TextEditingController();
  final TextEditingController pin2Controller = TextEditingController();
  final TextEditingController pin3Controller = TextEditingController();
  final TextEditingController pin4Controller = TextEditingController();
  final FocusNode pin1Focus = FocusNode();
  final FocusNode pin2Focus = FocusNode();
  final FocusNode pin3Focus = FocusNode();
  final FocusNode pin4Focus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pin1Controller.dispose();
    pin2Controller.dispose();
    pin3Controller.dispose();
    pin4Controller.dispose();
    pin1Focus.dispose();
    pin2Focus.dispose();
    pin3Focus.dispose();
    pin4Focus.dispose();
    super.dispose();
  }

  String getVerificationCode() {
    return pin1Controller.text +
        pin2Controller.text +
        pin3Controller.text +
        pin4Controller.text;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    
    final authRepo = AuthRemoteData(apiClient: ApiClient());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VerificationCodeCubit(authRepo)),
        BlocProvider(create: (context) => ForgetPasswordCubit()), // ليعمل Resend Code
      ],
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
                appLocalizations.verification,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 20.sp),
              ),
            ),
            SizedBox(width: 20.w),
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<VerificationCodeCubit, VerificationCodeState>(
              listener: (context, state) {
                if (state is VerificationCodeSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  NewPasswordScreen(email: widget.email,)),
                  );
                } else if (state is VerificationCodeFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                  );
                }
              },
            ),
            BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.green),
                  );
                } else if (state is ForgotPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ],
          child: SafeArea(
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
                        appLocalizations.verificationCode,
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        appLocalizations.typeTheVerificationCodeWeHaveSentYou,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PinField(controller: pin1Controller, focusNode: pin1Focus, nextFocusNode: pin2Focus),
                          SizedBox(width: 16.w),
                          PinField(controller: pin2Controller, focusNode: pin2Focus, nextFocusNode: pin3Focus),
                          SizedBox(width: 16.w),
                          PinField(controller: pin3Controller, focusNode: pin3Focus, nextFocusNode: pin4Focus),
                          SizedBox(width: 16.w),
                          PinField(controller: pin4Controller, focusNode: pin4Focus, nextFocusNode: null),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${appLocalizations.youDidntReceiveAnyCode}? ",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                          
                          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                            builder: (context, state) {
                              if (state is ForgotPasswordLoading) {
                                return const SizedBox(
                                  height: 15, width: 15, 
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                );
                              }
                              return TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  context.read<ForgetPasswordCubit>().sendOtp(email: widget.email);
                                },
                                child: Text(
                                  appLocalizations.resendCode,
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF031B4E),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 48.h),
                      BlocBuilder<VerificationCodeCubit, VerificationCodeState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is VerificationCodeLoading
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<VerificationCodeCubit>().verifyCode(
                                              email: widget.email,
                                              code: getVerificationCode(),
                                            );
                                      }
                                    },
                              child: state is VerificationCodeLoading
                                  ? const SizedBox(
                                      height: 20, width: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : Text(appLocalizations.verify),
                            ),
                          );
                        },
                      ),
                    ],
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