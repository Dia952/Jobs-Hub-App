import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/user_controller.dart';
import 'package:jobs_hub/Models/user_singleton.dart';

import '../../Models/user_model.dart';
import '../../shared/components/components.dart';
import '../main_screen.dart';

enum ImageType {
  Profile,
  Cover,
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserController userController = UserController();
  User user = UserSingleton().user;

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
  bool isLoading = false;
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
    'Accounting',
    'Healthcare',
    'Education',
  ];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);
    usernameController = TextEditingController(text: user.username);
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
    cityController = TextEditingController(text: user.city);
    educationController = TextEditingController(text: user.education);
    gpaController = TextEditingController(text: user.gpa);
    bioController = TextEditingController(text: user.bio);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    statusSelectedValue = user.status ?? '';
    interestSelectedValue = user.interest ?? '';
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

  File? _selectedCoverImage;
  File? _selectedProfileImage;

  void _selectImage(ImageType imageType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File selectedImage = File(result.files.single.path!);
      setState(() {
        if (imageType == ImageType.Profile) {
          _selectedProfileImage = selectedImage;
          // user.profileImage = selectedImage;
        } else if (imageType == ImageType.Cover) {
          _selectedCoverImage = selectedImage;
          // user.profileImage = selectedImage;
          // user.profileCoverImage = selectedImage;
        }
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
        titleSpacing: 5.0,
        actions: [
          if (_selectedProfileImage != null || _selectedCoverImage != null)
            ElevatedButton(
              onPressed: () {
                if (_selectedProfileImage != null) {
                  user.profileImage = _selectedProfileImage;
                }
                if (_selectedCoverImage != null) {
                  user.coverImage = _selectedCoverImage;
                }

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(index: 2),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Image updated successfully!'),
                  duration: Duration(milliseconds: 1300),
                ));
              },
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
        ],
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
                              image: (_selectedCoverImage != null)
                                  ? DecorationImage(
                                      image: FileImage(_selectedCoverImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : (user.coverImage != null)
                                      ? DecorationImage(
                                          image: FileImage(user.coverImage!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectImage(ImageType.Cover),
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
                                      backgroundImage: (_selectedProfileImage !=
                                              null)
                                          ? FileImage(_selectedProfileImage!)
                                          : (user.profileImage != null)
                                              ? FileImage(user.profileImage!)
                                                  as ImageProvider
                                              : const AssetImage(
                                                  'assets/images/user_image.png'),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _selectImage(ImageType.Profile),
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
                              const SizedBox(
                                width: 7,
                              ),
                              Flexible(
                                // padding: const EdgeInsets.only(left: 7),
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
                    !isLoading
                        ? defaultButton(
                            text: 'Save Changes',
                            function: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });

                                user.firstName = firstNameController.text;
                                user.lastName = lastNameController.text;
                                user.username = usernameController.text;
                                user.phone = phoneController.text;
                                user.email = emailController.text;
                                user.city = cityController.text;
                                user.education = educationController.text;
                                user.gpa = gpaController.text;
                                user.bio = bioController.text;
                                user.status = statusSelectedValue;
                                user.interest = interestSelectedValue;

                                if (changePassword) {
                                  user.password = passwordController.text;
                                }

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                final isUpdated =
                                    await userController.updateUser();

                                if (isUpdated) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MainScreen(index: 2),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        Text('Profile updated successfully!'),
                                    duration: Duration(milliseconds: 1300),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('An error occurred..'),
                                    duration: Duration(milliseconds: 1300),
                                  ));
                                }
                              }
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                            ),
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
