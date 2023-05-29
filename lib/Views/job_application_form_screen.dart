import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jobs_hub/Controllers/job_controller.dart';
import 'package:path/path.dart' as p;

import '../Models/user_model.dart';
import '../Models/user_singleton.dart';

class JobApplicationFormScreen extends StatefulWidget {
  final int jobId;

  const JobApplicationFormScreen({
    super.key,
    required this.jobId,
  });

  @override
  State<JobApplicationFormScreen> createState() =>
      _JobApplicationFormScreenState();
}

class _JobApplicationFormScreenState extends State<JobApplicationFormScreen> {
  User user = UserSingleton().user;
  JobController jobController = JobController();

  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController gpaController = TextEditingController();

  late int jobId;

  String? _cvFilePath;
  String? _cvFileName;
  Uint8List? _cvFileBytes;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    fullNameController =
        TextEditingController(text: "${user.firstName} ${user.lastName}");
    emailController = TextEditingController(text: user.email);
    cityController = TextEditingController(text: user.city);
    phoneNumberController = TextEditingController(text: user.phone);
    gpaController = TextEditingController(text: user.gpa);
    jobId = widget.jobId;
  }

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
    _cvFilePath = result?.files.single.path;
    _cvFileBytes = result?.files.single.bytes;

    if (result != null) {
      setState(() {
        _cvFileName = result.files.single.name;
      });
    }
  }

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      if (_cvFileName == null || _cvFileName == 'Please upload a CV file.') {
        setState(() {
          _cvFileName = 'Please upload a CV file.';
        });
        return;
      }
      isLoading = true;
      final fullName = fullNameController.text;
      final email = emailController.text;
      final city = cityController.text;
      final phoneNumber = phoneNumberController.text;
      final gpa = gpaController.text;
      final cvFileName = _cvFileName!;

      int res = await jobController.jobApply(
        fullName,
        email,
        city,
        phoneNumber,
        gpa,
        jobId,
        cvFileName,
        // _cvFileBytes,
      );

      if (res == 200 || res == 201) {
        // Reset the form
        formKey.currentState!.reset();

        // Clear the CV file path
        setState(() {
          _cvFilePath = null;
          _cvFileName = null;
        });
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pop(context);
        // Show a success message or navigate back to the previous screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Form submitted successfully!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred...'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
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
                  if (_cvFileName != null)
                    Text(
                      _cvFileName!,
                      style: const TextStyle(color: Colors.blue),
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
              !isLoading
                  ? ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    )
                  : const Center(
                      child: CircularProgressIndicator(strokeWidth: 1.5))
            ],
          ),
        ),
      ),
    );
  }
}
