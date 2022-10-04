import 'package:chat_application/helper/navigation.dart';
import 'package:chat_application/screens/auth/auth_index.dart';
import 'package:chat_application/screens/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Authentication>(builder: (_, auth, __) {
        return Column(
          children: [
            Text(auth.loggedUser!.username),
            Text(auth.loggedUser!.email),
            Center(
              child: ElevatedButton(
                child: Text('Logout'),
                onPressed: () {
                  context
                      .read<Authentication>()
                      .logout()
                      .then(() => pushReplacement(context, const AuthIndex()));
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
