import 'package:chat_application/screens/auth/auth_provider.dart';
import 'package:chat_application/screens/login_screen/login.dart';
import 'package:chat_application/screens/sign_up_screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthIndex extends StatelessWidget {
  const AuthIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(builder: (_, auth, __) {
      if (auth.isLogin) {
        return const LoginScreen();
      } else {
        return const SignUp();
      }
    });
  }
}
