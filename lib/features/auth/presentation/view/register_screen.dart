import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:med_rent/features/auth/presentation/view/login_screen.dart';
import 'package:med_rent/features/auth/presentation/widgets/custom_auth_text_field.dart';
import 'package:med_rent/features/auth/presentation/widgets/social%20_category.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Sign up",
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
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 30.h),
                  Text(
                    'Welcome!',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.copyWith(fontSize: 24),
                  ),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
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
                    // TextFormField(
                    //   controller: emailController,
                    //   style: TextStyle(color: Colors.black),
                    //   cursorColor: Colors.black,
                    //   keyboardType: TextInputType.emailAddress,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Color(0xFFFFFFFF),
                    //     labelText: 'Email',
                    //     labelStyle: Theme.of(context).textTheme.labelLarge,
                    //     hintText: 'Enter your email',
                    //     hintStyle: Theme.of(context).textTheme.bodyMedium!
                    //         .copyWith(color: Color(0xFF676767)),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF000000)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),

                    //       borderSide: BorderSide(color: Color(0xFF676767)),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Email required";
                    //     }
                    //     if (!value.contains('@')) {
                    //       return 'Enter a valid email ';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name required";
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: nameController,
                    //   style: TextStyle(color: Colors.black),
                    //   cursorColor: Colors.black,
                    //   keyboardType: TextInputType.emailAddress,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Color(0xFFFFFFFF),
                    //     labelText: 'Name',
                    //     labelStyle: Theme.of(context).textTheme.labelLarge,
                    //     hintText: 'Enter your name',
                    //     hintStyle: Theme.of(context).textTheme.bodyMedium!
                    //         .copyWith(color: Color(0xFF676767)),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF000000)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),

                    //       borderSide: BorderSide(color: Color(0xFF676767)),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Name required";
                    //     }

                    //     return null;
                    //   },
                    // ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: passwordController,
                      labelText: 'Password',
                      hintText: '******',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password required";
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: passwordController,
                    //   style: TextStyle(color: Colors.black),
                    //   cursorColor: Colors.black,
                    //   obscureText: obscurePassword,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Color(0xFFFFFFFF),
                    //     labelText: 'Password',
                    //     labelStyle: Theme.of(context).textTheme.labelLarge,
                    //     hintText: '******',
                    //     hintStyle: Theme.of(context).textTheme.bodyMedium!
                    //         .copyWith(color: Color(0xFF676767)),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF000000)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //       borderSide: BorderSide(color: Color(0xFF676767)),
                    //     ),
                    //     suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           obscurePassword = !obscurePassword;
                    //         });
                    //       },
                    //       icon: Icon(
                    //         obscurePassword ? Icons.visibility_off : Icons.visibility,
                    //       ),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Password required";
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    child: CustomAuthTextFormField(
                      controller: confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: '******',
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm Password required";
                        }
                        if (value != passwordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                    // TextFormField(
                    //   controller: confirmPasswordController,
                    //   style: TextStyle(color: Colors.black),
                    //   cursorColor: Colors.black,
                    //   obscureText: obscurePasswordConfirm,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Color(0xFFFFFFFF),
                    //     labelText: 'Confirm Password',
                    //     labelStyle: Theme.of(context).textTheme.labelLarge,
                    //     hintText: '******',
                    //     hintStyle: Theme.of(context).textTheme.bodyMedium!
                    //         .copyWith(color: Color(0xFF676767)),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF000000)),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //       borderSide: BorderSide(color: Color(0xFF676767)),
                    //     ),
                    //     suffixIcon: IconButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           obscurePasswordConfirm = !obscurePasswordConfirm;
                    //         });
                    //       },
                    //       icon: Icon(
                    //         obscurePasswordConfirm ? Icons.visibility_off : Icons.visibility,
                    //       ),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Confirm Password required";
                    //     }
                    //     if (value != passwordController.text) {
                    //       return "Passwords don't match";
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                  SizedBox(height: 28.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: Text("Sign Up"),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 1, color: Color(0xFF676767)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
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

                      const SizedBox(width: 20),
                      SocialImage(
                        asset: "assets/images/google.png",
                        onTap: () {
                          print("Google Sign-In ");
                        },
                      ),

                      const SizedBox(width: 20),
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
                        "Already have account? ",
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(fontSize: 14),
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
                          'Log in ',
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(fontSize: 14, color: Color(0xFF031B4E)),
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
