class User {
  String? id = '';
  String? username = '';
  String? password = '';
  String? profileImage;
  String? profileCoverImage;
  String? firstName = '';
  String? lastName = '';
  String? phone = '';
  String? email = '';
  String? city = '';
  String? education = '';
  String? gpa = '';
  String? bio = '';
  String? status = '';
  String? experience = '';
  List<String>? skills = [];

  User({
    this.id,
    this.profileImage,
    this.profileCoverImage,
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
    this.skills,
  });
}
