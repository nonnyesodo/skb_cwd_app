import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:skb_cwd_app/Features/UserFeatures/auth/presentation/bloc/cubit/auth_cubit.dart';
import 'package:skb_cwd_app/config/page%20route/detail/route_name.dart';
import 'package:skb_cwd_app/constants/utils/auth_validator.dart';

import '../../../../../globalwidget/export.dart';

/////login page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchAuth = context.watch<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomNav, (route) => false);
        }
        if (state is AuthAdminState) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteName.bottomNav, (route) => false);
        }
      },
      child: AppScaffold(
        isloading: watchAuth.state is AuthLoadingState,
        body: Column(
          children: [
            const AppText(
                text: "Welcome Back", size: 35, fontweight: FontWeight.bold),
            const AppText(text: "Enter your credentials to login", size: 18),
            Form(
              key: formKey,
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  children: [
                    60.verticalSpace,
                    ApptextField(
                        controller: watchAuth.email,
                        prefixIcon: Icons.email,
                        validator: (value) =>
                            AuthValidator.validateEmail(value!),
                        title: "Email"),
                    20.verticalSpace,
                    ApptextField(
                      controller: watchAuth.password,
                      prefixIcon: Icons.password,
                      title: "Password",
                      validator: (p0) => AuthValidator.validateAnyField(
                          value: p0!, field: 'Password'),
                      sufixIcon:
                          obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    40.verticalSpace,
                    Appbutton(
                      label: 'Login',
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().loginUser();
                        }
                      },
                    ),
                    16.verticalSpace,
                    const AppText(
                        text: "Forgot password?",
                        fontweight: FontWeight.w600,
                        color: Colors.blueGrey),
                    16.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                            text: 'Don\'t have an account? ',
                            color: Colors.blueGrey),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.register);
                          },
                          child: const AppText(
                              text: "Sign Up",
                              fontweight: FontWeight.w700,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
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
