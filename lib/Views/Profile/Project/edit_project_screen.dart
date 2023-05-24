import 'package:flutter/material.dart';
import 'package:jobs_hub/shared/components/components.dart';

import '../../../Controllers/project_controller.dart';

class EditProjectScreen extends StatefulWidget {
  final String projectTitle;
  final String projectDescription;

  const EditProjectScreen({
    super.key,
    required this.projectTitle,
    required this.projectDescription,
  });

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final ProjectController projectController = ProjectController();
  late TextEditingController projectTitleTextController;
  late TextEditingController projectDescriptionTextController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    projectTitleTextController =
        TextEditingController(text: widget.projectTitle);
    projectDescriptionTextController =
        TextEditingController(text: widget.projectDescription);
  }

  @override
  void dispose() {
    projectTitleTextController.dispose();
    projectDescriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Project'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              const Text(
                'Project Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: projectTitleTextController,
                maxLength: 50,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a project title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Project Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: projectDescriptionTextController,
                maxLines: 20,
                maxLength: 1000,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a project description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    projectController.editProject();
                    Navigator.pop(context);
                  }
                },
                text: 'Save',
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
