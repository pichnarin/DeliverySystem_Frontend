class UserProfile {
  String userName;
  String phoneNumber;
  String dob;
  String gender;
  String? imagePath;

  UserProfile({
    required this.userName,
    required this.phoneNumber,
    required this.dob,
    required this.gender,
    this.imagePath,
  });
}
