import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/core/utils/validators/validators.dart';
import 'package:med_rent/features/auth/data/cubit/new_password_cubit.dart';
import 'package:med_rent/features/auth/presentation/view/done_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/l10n/app_localizations.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.email});
  final String email;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
create: (context) => NewPasswordCubit(),
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
                appLocalizations.createNewPassword,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontSize: 18.sp),
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
                child: BlocConsumer<NewPasswordCubit, NewPasswordState>(
                  listener: (context, state) {
                    if (state is NewPasswordSuccess) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => DoneScreen(),
                      );
                    } else if (state is NewPasswordFailure) {
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
                          appLocalizations.newPassword,
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          appLocalizations.pleaseWriteYourNewPassword,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(height: 40.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAuthTextFormField(
                            controller: newpasswordController,
                            labelText: appLocalizations.newPassword,
                            hintText: '******',
                            isPassword: true,
                            validator: (val) =>
                                AppValidators.validatePassword(context, val),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAuthTextFormField(
                            controller: confirmPasswordController,
                            labelText: appLocalizations.confirmPassword,
                            hintText: '******',
                            isPassword: true,
                            validator: (val) =>
                                AppValidators.validateConfirmPassword(
                                  context,
                                  val,
                                  newpasswordController.text,
                                ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is NewPasswordLoading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<NewPasswordCubit>()
                                          .newPassword(
                                            email: widget.email,
                                            newPassword:
                                                newpasswordController.text,
                                          );
                                    }
                                  },
                            child: state is NewPasswordLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(appLocalizations.confirm),
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
    );
  }
}
