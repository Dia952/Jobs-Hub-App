import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class JobApplicationFormScreen extends StatefulWidget {
  const JobApplicationFormScreen({super.key});

  @override
  State<JobApplicationFormScreen> createState() =>
      _JobApplicationFormScreenState();
}

class _JobApplicationFormScreenState extends State<JobApplicationFormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();

  String? _cvFilePath;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    cityController.dispose();
    phoneNumberController.dispose();
    gpaController.dispose();
    super.dispose();
  }

  Future<void> _pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _cvFilePath = result.files.single.path;
      });
    }
  }

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      // Perform form submission logic here
      // Access form field values using the controller values

      if (_cvFilePath == null || _cvFilePath == 'Please upload a CV file.') {
        setState(() {
          _cvFilePath = 'Please upload a CV file.';
        });
        return;
      }
      final fullName = fullNameController.text;
      final email = emailController.text;
      final city = cityController.text;
      final phoneNumber = phoneNumberController.text;
      final gpa = gpaController.text;

      // Access the CV file path
      final cvFilePath = _cvFilePath;

      // Perform logic with the form data

      // Reset the form
      formKey.currentState!.reset();

      // Clear the CV file path
      setState(() {
        _cvFilePath = null;
      });

      // Show a success message or navigate back to the previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: gpaController,
                decoration: const InputDecoration(labelText: 'GPA'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your GPA';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickCVFile,
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Upload CV'),
                  ),
                  const SizedBox(height: 12.0),
                  if (_cvFilePath != null)
                    Text(
                      p.basename(_cvFilePath!),
                      style: const TextStyle(color: Colors.blue),
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
