import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/auth/presentation/view/new_password_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/pin_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

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
    // TODO: implement dispose
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
              appLocalizations.verification,
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
                    appLocalizations.verificationCode,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    appLocalizations.typeTheVerificationCodeWeHaveSentYou,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PinField(
                        controller: pin1Controller,
                        focusNode: pin1Focus,
                        nextFocusNode: pin2Focus,
                      ),
                      SizedBox(width: 16.w),
                      PinField(
                        controller: pin2Controller,
                        focusNode: pin2Focus,
                        nextFocusNode: pin3Focus,
                      ),
                      SizedBox(width: 16.w),
                      PinField(
                        controller: pin3Controller,
                        focusNode: pin3Focus,
                        nextFocusNode: pin4Focus,
                      ),
                      SizedBox(width: 16.w),
                      PinField(
                        controller: pin4Controller,
                        focusNode: pin4Focus,
                        nextFocusNode: null,
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${appLocalizations.youDidntReceiveAnyCode}? ",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          appLocalizations.resendCode,
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(
                                fontSize: 14.sp,
                                color: Color(0xFF031B4E),
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String code = getVerificationCode();
                          print('$code');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPasswordScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(appLocalizations.verify),
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
