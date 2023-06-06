import 'dart:convert';
import 'dart:io';

import 'package:jobs_hub/Models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../shared/constants/base_api.dart';

final httpClient = HttpClient()
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;

final ioClient = IOClient(httpClient);

class AuthService {
  Future<User?> login(String username, String password) async {
    final url = Uri.parse('${BaseAPI.baseUrl}/signup/authenticateMobile');
    final body = jsonEncode({
      'userName': username,
      'password': password,
    });

    final response = await ioClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request successful

      final data = jsonDecode(response.body);
      final userData = data['userData'];

      final id = userData['id'].toString();
      final username = userData['userName'];
      // final password = userData['password'].toString();
      final firstName = userData['firstName'];
      final lastName = userData['lastName'];
      dynamic phone = userData['phoneNumber'].toString();
      final email = userData['email'];
      final city = userData['city'];
      final education = userData['education'];
      dynamic gpa = userData['gpa'].toString();
      final bio = userData['bio'];
      dynamic status = userData['state'];
      dynamic interest = userData['interest'];
      dynamic experience = userData['experience'];

      List<String> statusOptions = [
        '',
        'Employed',
        'Unemployed',
        'Open to work',
        'Hiring',
      ];

      List<String> interestsOptions = [
        '',
        'IT',
        'Business',
        'Accounting',
        'Healthcare',
        'Education',
      ];

      if (gpa == 'null') gpa = '';
      if (phone == 'null') phone = '';
      if (experience == 'null') experience = '';
      if (!statusOptions.contains(status)) status = '';
      if (!interestsOptions.contains(interest)) interest = '';

      // Create a new User object with the extracted data
      final user = User(
        id: id,
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        email: email,
        city: city,
        education: education,
        gpa: gpa,
        bio: bio,
        status: status,
        interest: interest,
        experience: experience,
        skills: ['.NET, Angular', 'Flutter, Android', 'Python'],
      );

      return user;
    } else {
      // Request failed
      print('API call failed with status code: ${response.statusCode}');
      return null;
    }
  }

  Future<User?> register(String firstName, String lastName, String username,
      String email, String phone, String password) async {
    final url = Uri.parse('${BaseAPI.baseUrl}/signup/register');
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'userName': username,
      'password': password,
      'email': email,
      'phoneNumber': int.parse(phone),
      'role': 'user',
    });
    final response = await ioClient.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request successful
      final user = login(username, password);

      return user;
    } else {
      print('API call failed with status code: ${response.statusCode}');
      return null;
    }
  }
}
