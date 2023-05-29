import 'package:jobs_hub/Models/user_model.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  User user = User();

  void resetUser() {
    user = User();
  }
}
