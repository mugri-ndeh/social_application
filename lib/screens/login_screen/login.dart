import 'package:chat_application/helper/navigation.dart';
import 'package:chat_application/screens/home_screen/home_screen.dart';
import 'package:chat_application/util/app_interactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/widgets/input.dart';
import '../auth/auth_provider.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Authentication auth;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    auth = Provider.of<Authentication>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(builder: (_, provider, __) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    InputField(
                      controller: provider.emailController,
                      hint: 'email',
                      icon: const Icon(Icons.mail),
                    ),
                    const SizedBox(height: 8),
                    InputField(
                      controller: provider.passwordController,
                      hint: 'password',
                      password: true,
                      icon: const Icon(Icons.lock),
                      prefixIcon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 30),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        provider.login().then((value) {
                          if (value is String) {
                            AppInteractions.showErrorSnackBar(context, value);
                          } else {
                            auth.loggedUser = value;
                            pushReplacement(context, const HomeScreen());
                          }
                        });
                      },
                      child: Text('Login'),
                    )),
                    // const SizedBox(height: 50),
                    GestureDetector(
                      onTap: auth.toggleLogin,
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Don\'t have an account? '),
                                Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.greenAccent),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
