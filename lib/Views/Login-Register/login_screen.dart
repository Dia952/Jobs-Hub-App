// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/auth_controller.dart';
import 'package:jobs_hub/Views/main_screen.dart';

import '../../shared/components/components.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = AuthController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isLogin = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    passwordFocusNode.dispose();
    super.dispose();
  }

  void signIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 50,
                ),
                defaultFormField(
                  controller: usernameController,
                  onSubmit: (value) {
                    FocusScope.of(context).requestFocus(passwordFocusNode);
                  },
                  keyboardType: TextInputType.name,
                  label: 'Username',
                  prefix: Icons.person,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  onSubmit: (value) async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLogin = true;
                      });

                      // Perform the login
                      final loginResult = await authController.login(
                        usernameController.text,
                        passwordController.text,
                      );

                      setState(() {
                        isLogin = false;
                      });
                      if (loginResult != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(index: 0),
                          ),
                        );
                      } else if (loginResult == null) {
                        // Invalid credentials, show error message
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Invalid Credentials'),
                            content: const Text(
                                'Please check your username and password.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Other login error occurred, handle accordingly
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Login Error'),
                            content: const Text(
                                'An error occurred while logging in.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: isPassword,
                  label: 'Password',
                  prefix: Icons.lock,
                  suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                  suffixPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (!isLogin)
                  defaultButton(
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLogin = true;
                        });

                        // Perform the login
                        final loginResult = await authController.login(
                          usernameController.text,
                          passwordController.text,
                        );
                        setState(() {
                          isLogin = false;
                        });
                        if (loginResult != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(index: 0),
                            ),
                          );
                        } else if (loginResult == null) {
                          // Invalid credentials, show error message
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Invalid Credentials'),
                              content: const Text(
                                  'Please check your username and password.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Other login error occurred, handle accordingly
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Login Error'),
                              content: const Text(
                                  'An error occurred while logging in.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    text: 'Login',
                  ),
                if (isLogin) const CircularProgressIndicator(strokeWidth: 1.5),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
