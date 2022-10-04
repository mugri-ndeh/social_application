import 'package:chat_application/helper/navigation.dart';
import 'package:chat_application/screens/home_screen/home_provider.dart';
import 'package:chat_application/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/app_interactions.dart';
import '../../util/widgets/input.dart';
import '../auth/auth_provider.dart';
import 'sign_up_provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
      create: (context) => SignUpProvider(),
      child: Scaffold(
        body: Consumer<SignUpProvider>(builder: (_, provider, __) {
          return SafeArea(
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
                      'Create account',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    InputField(
                      controller: provider.usernameController,
                      hint: 'username',
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 8),
                    InputField(
                      controller: provider.confirmPasswordController,
                      hint: 'confirm password',
                      password: true,
                      icon: const Icon(Icons.lock),
                      prefixIcon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                        child: ElevatedButton(
                            onPressed: () {
                              provider.signUp().then((value) {
                                if (value is String) {
                                  AppInteractions.showErrorSnackBar(
                                      context, value);
                                } else {
                                  context.read<Authentication>().loggedUser =
                                      value;
                                  pushReplacement(context, const HomeScreen());
                                }
                              });
                            },
                            child: provider.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Sign Up'))),
                    GestureDetector(
                      onTap: auth.toggleLogin,
                      child: Center(
                        child: SizedBox(
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Already have an account? '),
                                Text(
                                  'Login',
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
          );
        }),
      ),
    );
  }
}
