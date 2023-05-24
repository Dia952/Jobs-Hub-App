import 'dart:io';

import 'package:flutter/material.dart';

import 'package:jobs_hub/shared/components/components.dart';

import '../../../Controllers/experience_controller.dart';
import 'package:path/path.dart';

class EditExperienceScreen extends StatefulWidget {
  final String experience;
  final List<String> skills;

  const EditExperienceScreen({
    super.key,
    required this.experience,
    required this.skills,
  });

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  ExperienceController expController = ExperienceController();

  late TextEditingController experienceTextEditingController;
  List<TextEditingController> skillsTextEditingControllers = [];

  @override
  void initState() {
    super.initState();
    experienceTextEditingController =
        TextEditingController(text: widget.experience);
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
                      File? uploadedFile = await expController.uploadCV();
                      setState(() {
                        expController.uploadedCV = uploadedFile;
                      });
                    },
                    child: const Text('Upload'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (expController.uploadedCV != null)
              GestureDetector(
                onTap: expController.openCV,
                child: Text(
                  basename(expController.uploadedCV!.path),
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
            defaultButton(
              function: () {},
              text: 'Save',
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
