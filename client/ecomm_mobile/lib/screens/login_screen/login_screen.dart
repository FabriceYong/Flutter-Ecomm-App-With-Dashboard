import 'package:ecomm_mobile/screens/home_screen.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginAfterSignUp: false,
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: (loginData) {
        return null;

        // TODO: should complete call login
      },
      onSignup: (SignupData data) {
        return null;

        // TODO: should complete call register;
      },
      onSubmitAnimationCompleted: () {
        if (context.userProvider.getLoginUser()?.sId != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
      onRecoverPassword: (_) => null,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
        primaryColor: AppColor.darkGrey,
        accentColor: AppColor.darkOrange,
        buttonTheme: const LoginButtonTheme(
          backgroundColor: AppColor.darkOrange,
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        titleStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}
