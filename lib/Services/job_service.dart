import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/job_model.dart';

class JobService {
  Future<List<Job>> getJobs() async {
    final url = Uri.parse('https://localhost:7151/forApplyjob/GetpushJob');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request successful

      final parsedData = json.decode(response.body);

      final jobsData = parsedData as List<dynamic>;

      // Create a list to store the Job instances
      final List<Job> jobs = [];

      for (final jobData in jobsData) {
        final id = jobData['id'];
        final title = jobData['title'] as String;
        final description = jobData['description'] as String;
        final requirements = jobData['requrment'] as String;
        final email = jobData['email'] as String;
        final address = jobData['place'] as String;
        // final address = jobData['company']['address'] as String;
        final deadline = DateTime.parse(jobData['job_Deadline']);
        // Create a new Job instance and add it to the list
        final job = Job(
          id: id,
          title: title,
          description: description,
          requirements: requirements,
          email: email,
          address: address,
          deadline: deadline,
        );
        jobs.add(job);
      }

      return jobs;
    } else {
      // Request failed
      print('API call failed with status code: ${response.statusCode}');
      return [];
    }
  }

  Future<int> jobApply(String fullName, String email, String city, String phone,
      String gpa, int jobId, String cvFileName) async {
    // final base64Image = base64Encode(cvFileBytes);
    final url = Uri.parse('https://localhost:7151/applyjob');

    final body = jsonEncode({
      "full_Name": fullName,
      "email": email,
      "city": city,
      "phone_Number": int.parse(phone),
      "gpa": int.parse(gpa.split('.')[0]),
      "pushJobid": jobId,
      "fileDisplayName": cvFileName,
      "imageFile": null
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request successful
      print(response.body);
      return response.statusCode;
    } else {
      print('API call failed with status code: ${response.statusCode}');
      print(response.body);

      return response.statusCode;
    }
  }
}
