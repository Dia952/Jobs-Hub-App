import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:jobs_hub/Models/user_singleton.dart';
import 'package:jobs_hub/shared/components/components.dart';

import '../../../Controllers/user_controller.dart';
import '../../../Models/user_model.dart';
import '../../main_screen.dart';

class EditExperienceScreen extends StatefulWidget {
  final List<String> skills;

  const EditExperienceScreen({
    super.key,
    required this.skills,
  });

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  UserController userController = UserController();
  User user = UserSingleton().user;

  bool isLoading = false;

  late TextEditingController experienceTextEditingController;
  List<TextEditingController> skillsTextEditingControllers = [];

  @override
  void initState() {
    super.initState();
    experienceTextEditingController =
        TextEditingController(text: user.experience);
    for (String skill in widget.skills) {
      skillsTextEditingControllers.add(TextEditingController(text: skill));
    }
  }

  @override
  void dispose() {
    experienceTextEditingController.dispose();

    for (var controller in skillsTextEditingControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Experience'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: experienceTextEditingController,
              maxLines: 19,
              maxLength: 2000,
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                const Text(
                  'Resume / CV',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () async {
                      File? uploadedFile = await userController.uploadCV();
                      setState(() {
                        userController.uploadedCV = uploadedFile;
                      });
                    },
                    child: const Text('Upload'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (userController.uploadedCV != null)
              GestureDetector(
                onTap: userController.openCV,
                child: Text(
                  basename(userController.uploadedCV!.path),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                const Text(
                  'Skills',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: addField,
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: skillsTextEditingControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.fiber_manual_record,
                        size: 13,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: skillsTextEditingControllers[index],
                        decoration: const InputDecoration(
                            // labelText: 'Skill ${index + 1}',
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => removeField(index),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32.0),
            !isLoading
                ? defaultButton(
                    function: () async {
                      setState(() {
                        isLoading = true;
                      });
                      user.experience = experienceTextEditingController.text;
                      Future.delayed(const Duration(seconds: 1));
                      final isUpdated = await userController.updateUser();

                      if (isUpdated) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(index: 2),
                            ));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Experience updated successfully!'),
                          duration: Duration(milliseconds: 1300),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('An error occurred..'),
                          duration: Duration(milliseconds: 1300),
                        ));
                      }
                    },
                    text: 'Save',
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ),
                  ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void addField() {
    setState(() {
      skillsTextEditingControllers.add(TextEditingController());
    });
  }

  void removeField(int index) {
    setState(() {
      skillsTextEditingControllers.removeAt(index);
    });
  }
}
