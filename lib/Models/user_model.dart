import 'dart:io';

import 'package:jobs_hub/Models/project_model.dart';

class User {
  String? id = '';
  String? username = '';
  String? password = '';
  File? profileImage;
  File? coverImage;
  String? firstName = '';
  String? lastName = '';
  dynamic phone = '';
  String? email = '';
  String? city = '';
  String? education = '';
  dynamic gpa = '';
  String? bio = '';
  String? status = '';
  String? experience = '';
  String? interest = '';
  List<String>? skills = [];
  // List<Project>? projects = [];

  User({
    this.id,
    this.profileImage,
    this.coverImage,
    this.username,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.city,
    this.education,
    this.gpa,
    this.bio,
    this.status,
    this.experience,
    this.interest,
    this.skills,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': "user",
      'id': int.parse(id!),
      'userName': username,
      'password': password,
      // 'profileImage': profileImage,
      // 'profileCoverImage': profileCoverImage,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': int.parse(phone),
      'email': email,
      'city': city,
      'education': education,
      'gpa': gpa == '' ? null : int.parse(gpa.split('.')[0]),
      'bio': bio,
      'state': status,
      'interest': interest,
      'experience': experience,
    };
  }
}
