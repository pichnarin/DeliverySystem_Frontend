import 'package:flutter/material.dart';
import '../model/user_profile.dart';

class UserProvider with ChangeNotifier {
  UserProfile _user = UserProfile(
    userName: '',
    phoneNumber: '',
    dob: '',
    gender: 'Male',
    imagePath: '',
  );

  UserProfile get user => _user;

  void updateUser(UserProfile updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }
}
