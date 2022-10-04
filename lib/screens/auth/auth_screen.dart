import 'package:chat_application/screens/auth/auth_index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_screen/home_screen.dart';
import '../login_screen/login.dart';
import 'auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Authentication>(
      builder: (_, auth, __) {
        if (auth.loading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (auth.loggedUser == null && auth.loading == false) {
          return const AuthIndex();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
