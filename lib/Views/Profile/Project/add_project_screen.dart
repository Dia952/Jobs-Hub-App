import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/project_controller.dart';
import 'package:jobs_hub/shared/components/components.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final ProjectController projectController = ProjectController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? projectTitle;
  String? projectDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project'),
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
                maxLength: 50,
                onChanged: (value) => projectTitle = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
                maxLines: 20,
                maxLength: 1000,
                onChanged: (value) => projectDescription = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32.0),
              defaultButton(
                function: () {
                  if (formKey.currentState!.validate()) {
                    projectController.addProject();
                    Navigator.pop(context);
                  }
                },
                text: 'Add',
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
