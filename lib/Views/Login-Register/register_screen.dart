import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/auth_controller.dart';
import 'package:jobs_hub/Views/main_screen.dart';

import '../../shared/components/components.dart';
import '../Profile/profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthController authController = AuthController();
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  final lastNameFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool isPassword = true;
  bool passwordMatch = true;
  bool isRegister = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();

    lastNameFocusNode.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

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
                  Icons.app_registration,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: defaultFormField(
                            controller: firstNameController,
                            onSubmit: (value) {
                              FocusScope.of(context)
                                  .requestFocus(lastNameFocusNode);
                            },
                            keyboardType: TextInputType.name,
                            label: 'First Name',
                            // prefix: Icons.person,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter a first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: defaultFormField(
                            controller: lastNameController,
                            focusNode: lastNameFocusNode,
                            onSubmit: (value) {
                              FocusScope.of(context)
                                  .requestFocus(usernameFocusNode);
                            },
                            keyboardType: TextInputType.name,
                            label: 'Last Name',
                            // prefix: Icons.person,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter a last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: usernameController,
                      focusNode: usernameFocusNode,
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      keyboardType: TextInputType.name,
                      label: 'Username',
                      prefix: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(phoneFocusNode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      onSubmit: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
                      keyboardType: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: Icons.phone_iphone_sharp,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone number';
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
                      onSubmit: (value) {
                        FocusScope.of(context)
                            .requestFocus(confirmPasswordFocusNode);
                      },
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: isPassword,
                      label: 'Password',
                      prefix: Icons.lock,
                      suffix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      suffixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      onSubmit: (value) async {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            authController.register(
                              firstNameController.text,
                              lastNameController.text,
                              usernameController.text,
                              emailController.text,
                              phoneController.text,
                              passwordController.text,
                            );

                            setState(() {
                              passwordMatch = true;
                              isRegister = true;
                            });
                            await Future.delayed(const Duration(seconds: 2));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MainScreen(index: 0),
                              ),
                            );
                          } else if (passwordMatch) {
                            setState(() {
                              passwordMatch = false;
                            });
                          }
                        }
                      },
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: isPassword,
                      label: 'Confirm Password',
                      prefix: Icons.lock,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                if (!passwordMatch)
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: const [
                          Text(
                            'Passwords don\'t match, Please check your password',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 25,
                ),
                if (!isRegister)
                  defaultButton(
                    function: () async {
                      if (formKey.currentState!.validate()) {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          authController.register(
                            firstNameController.text,
                            lastNameController.text,
                            usernameController.text,
                            emailController.text,
                            phoneController.text,
                            passwordController.text,
                          );

                          setState(() {
                            passwordMatch = true;
                            isRegister = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(index: 0),
                            ),
                          );
                        } else if (passwordMatch) {
                          setState(() {
                            passwordMatch = false;
                          });
                        }
                      }
                    },
                    text: 'Register',
                  ),
                if (isRegister)
                  const CircularProgressIndicator(strokeWidth: 1.5),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
