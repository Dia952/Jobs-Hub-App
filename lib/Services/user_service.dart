import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jobs_hub/Models/user_singleton.dart';

import '../Models/user_model.dart';

class UserService {
  User user = UserSingleton().user;

  Future<bool> updateUser() async {
    final userJson = user.toJson();

    final url = Uri.parse('https://localhost:7151/update/updateuser');
    final body = jsonEncode(userJson);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
