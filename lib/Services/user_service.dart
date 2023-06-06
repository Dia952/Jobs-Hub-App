import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

import 'package:jobs_hub/Models/user_singleton.dart';

import '../Models/user_model.dart';
import '../shared/constants/base_api.dart';

final httpClient = HttpClient()
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;

final ioClient = IOClient(httpClient);

class UserService {
  User user = UserSingleton().user;

  Future<bool> updateUser() async {
    final userJson = user.toJson();

    final url = Uri.parse('${BaseAPI.baseUrl}/update/updateuser');
    final body = jsonEncode(userJson);
    final response = await ioClient.post(
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
