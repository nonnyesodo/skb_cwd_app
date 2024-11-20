import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:skb_cwd_app/config/page%20route/detail/route_name.dart';
import 'package:skb_cwd_app/constants/utils/auth_validator.dart';

import '../../../../../globalwidget/export.dart';

///register page
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final watchAuth = context.watch<AuthCubit>();
    final size = MediaQuery.sizeOf(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisteredState) {
          Navigator.pushNamed(context, RouteName.bottomNav);
        }
      },
      child: AppScaffold(
        isloading: watchAuth.state is AuthLoadingState,
        body: Column(
          children: [
            const AppText(
                text: "Sign up", size: 35, fontweight: FontWeight.bold),
            const AppText(
                text: "Create your account", size: 18, color: Colors.blueGrey),
            20.verticalSpace,
            Form(
              key: formKey,
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  children: [
                    ApptextField(
                      controller: watchAuth.firstName,
                      title: "Firstname",
                      prefixIcon: Icons.person,
                      validator: (v) => AuthValidator.validateName(v!),
                    ),
                    16.verticalSpace,
                    ApptextField(
                        validator: (v) => AuthValidator.validateName(v!),
                        controller: watchAuth.lastName,
                        title: "Lastname",
                        prefixIcon: Icons.person),
                    16.verticalSpace,
                    ApptextField(
                        validator: (v) => AuthValidator.validateEmail(v!),
                        controller: watchAuth.email,
                        title: "Email",
                        prefixIcon: Icons.email),
                    16.verticalSpace,
                    ApptextField(
                        validator: (v) => AuthValidator.validateMobile(v!),
                        controller: watchAuth.phoneNumber,
                        title: "Phone Number",
                        prefixIcon: Icons.phone),
                    16.verticalSpace,
                    ApptextField(
                        validator: (v) => AuthValidator.validatePassword(v!),
                        controller: watchAuth.password,
                        title: "Password",
                        prefixIcon: Icons.password),
                    16.verticalSpace,
                    ApptextField(
                        validator: (p0) => watchAuth.password.text !=
                                watchAuth.confirmPassword.text
                            ? 'PasswordMisMatch'
                            : null,
                        controller: watchAuth.confirmPassword,
                        title: "Confirm Password",
                        prefixIcon: Icons.password),
                    30.verticalSpace,
                    Appbutton(
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().registerUser();
                        }
                      },
                      child: const AppText(
                          text: "Sign up", size: 20, color: Colors.white),
                    ),
                    10.verticalSpace,
                    const Center(
                        child: AppText(
                      text: "Or",
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                            text: "Already have an account? ",
                            size: 18,
                            color: Colors.blueGrey),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.login);
                          },
                          child: const AppText(
                              text: "Login",
                              fontweight: FontWeight.w600,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                    20.verticalSpace
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
