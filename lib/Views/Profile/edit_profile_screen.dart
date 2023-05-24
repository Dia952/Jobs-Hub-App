import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/user_controller.dart';
import 'package:jobs_hub/Models/user_singleton.dart';

import '../../Models/user_model.dart';
import '../../shared/components/components.dart';
import '../main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserController userController = UserController();
  User userData = UserSingleton().user;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController cityController;
  late TextEditingController educationController;
  late TextEditingController gpaController;
  late TextEditingController bioController;

  bool changePassword = false;
  bool passwordVisible = false;
  final passwordFocusNode = FocusNode();

  String? statusSelectedValue = '';
  String? interestSelectedValue = '';

  List<String> statusOptions = [
    '',
    'Employed',
    'Unemployed',
    'Open to work',
    'Hiring',
  ];

  List<String> interestOptions = [
    '',
    'IT',
    'Business',
    'Economy',
    'Sports',
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: userData.firstName);
    lastNameController = TextEditingController(text: userData.lastName);
    usernameController = TextEditingController(text: userData.username);
    phoneController = TextEditingController(text: userData.phone);
    emailController = TextEditingController(text: userData.email);
    cityController = TextEditingController(text: userData.city);
    educationController = TextEditingController(text: userData.education);
    gpaController = TextEditingController(text: userData.gpa);
    bioController = TextEditingController(text: userData.bio);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    statusSelectedValue = userData.status ?? '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    cityController.dispose();
    educationController.dispose();
    gpaController.dispose();
    bioController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
        titleSpacing: 5.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 120.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20.0,
                              child: Icon(
                                Icons.camera_alt,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 62.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 60.0,
                                      backgroundImage: NetworkImage(userData
                                              .profileImage ??
                                          'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      '${firstNameController.text} ${lastNameController.text}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    statusSelectedValue != ''
                                        ? Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Text(
                                                'Status : $statusSelectedValue',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 15,
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField(
                      value: statusSelectedValue,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                      onChanged: (value) {
                        setState(() {
                          statusSelectedValue = value as String;
                        });
                      },
                      items: statusOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField(
                      value: interestSelectedValue,
                      decoration: const InputDecoration(
                        labelText: 'Interests',
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                      onChanged: (value) {
                        setState(() {
                          interestSelectedValue = value as String;
                        });
                      },
                      items: interestOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(
                        labelText: 'City',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: educationController,
                      decoration: const InputDecoration(
                        labelText: 'Education',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: gpaController,
                      decoration: const InputDecoration(
                        labelText: 'GPA',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                      ),
                      maxLines: 3,
                      maxLength: 150,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Switch(
                          value: changePassword,
                          onChanged: (value) {
                            setState(() {
                              changePassword = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (changePassword) ...[
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        focusNode: passwordFocusNode,
                        obscureText: !passwordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a new password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                        ),
                        obscureText: !passwordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (passwordController.text != value) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 32.0),
                    defaultButton(
                      text: 'Save Changes',
                      function: () {
                        if (formKey.currentState!.validate()) {
                          // Perform update profile logic here
                          // Update user data and save it

                          userData.firstName = firstNameController.text;
                          userData.lastName = lastNameController.text;
                          userData.username = usernameController.text;
                          userData.phone = phoneController.text;
                          userData.email = emailController.text;
                          userData.city = cityController.text;
                          userData.education = educationController.text;
                          userData.gpa = gpaController.text;
                          userData.bio = bioController.text;
                          userData.status = statusSelectedValue;

                          if (changePassword) {
                            userData.password = passwordController.text;
                          }

                          // // Save the updated user data
                          userController.updateUser(userData);
                          // // Show success message or navigate back
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile updated successfully'),
                                duration: Duration(milliseconds: 1300),
                                closeIconColor: Colors.white,
                                showCloseIcon: true,
                              ),
                            );
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(index: 2),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}