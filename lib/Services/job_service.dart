import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../Models/job_model.dart';
import '../shared/constants/base_api.dart';

final httpClient = HttpClient()
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;

final ioClient = IOClient(httpClient);

class JobService {
  Future<List<Job>> getJobs() async {
    final url = Uri.parse('${BaseAPI.baseUrl}/forApplyjob/GetpushJob');
    final response = await ioClient.get(
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
        final title = jobData['title'];
        final preTitle = jobData['pre_title'];
        final category = jobData['category'];
        final description = jobData['description'];
        final requirements = jobData['requrment'];
        final email = jobData['email'];
        final address = jobData['place'];
        // final address = jobData['company']['address'] as String;
        final deadline = DateTime.parse(jobData['job_Deadline']);
        final publishDate = DateTime.parse(jobData['job_PuplishDate']);
        // Create a new Job instance and add it to the list
        final job = Job(
          id: id,
          title: title,
          preTitle: preTitle,
          category: category,
          description: description,
          requirements: requirements,
          email: email,
          address: address,
          deadline: deadline,
          publishDate: publishDate,
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
    final url = Uri.parse('${BaseAPI.baseUrl}/applyjob');

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

    final response = await ioClient.post(
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
