import 'package:jobs_hub/Models/user_model.dart';

class AuthService {
  Future<User?> login(String username, String password) async {
    // Simulate API call or authentication process
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with your actual API call to log in the user
    // For demonstration purposes, we return a user object with hardcoded data
    if (username == 's3' && password == 's3') {
      return User(
        id: '10',
        username: 'ahmad.ali',
        password: '',
        firstName: 'Ahmad',
        lastName: 'Ali',
        phone: '+97259000000',
        email: 'ahmad.ali@email.com',
        city: 'Ramallah',
        education: 'BSc Computer Engineering',
        gpa: '3.2',
        bio: 'Some bio...',
        status: 'Open to work',
        experience: 'Some experience..',
        skills: ['.NET, Angular', 'Flutter, Android', 'Python'],
      );
    } else {
      throw 'Invalid credentials';
    }
  }

  Future<User?> register(String firstName, String lastName, String username,
      String email, String phone, String password) async {
    // Simulate API call or registration process
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with your actual API call to register the user
    // For demonstration purposes, we return a user object with hardcoded data
    return User(
      id: '1',
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
