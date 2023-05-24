import 'package:flutter/material.dart';
import 'package:jobs_hub/Controllers/project_controller.dart';

import 'edit_project_screen.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final ProjectController projectController = ProjectController();
  final String projectTitle;
  final String projectDescription;

  ProjectDetailsScreen({
    super.key,
    required this.projectTitle,
    required this.projectDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
            Text(
              projectTitle,
              // maxLines: 2,
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Text(
              'Project Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              projectDescription,
            ),
            const SizedBox(height: 50.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProjectScreen(
                            projectTitle: projectTitle,
                            projectDescription: projectDescription,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('EDIT'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(projectTitle),
                          content: const Text(
                              'Are you sure you want to delete this project?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                projectController.deleteProject();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Project deleted successfully'),
                                  duration: Duration(milliseconds: 1300),
                                  closeIconColor: Colors.white,
                                  showCloseIcon: true,
                                ));
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(
                                    context); // Pop the current screen
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('DELETE'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
