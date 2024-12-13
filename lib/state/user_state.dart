import 'package:flutter/material.dart';
import '../repository/shared_prefs_user_repository.dart';

class UserState extends ChangeNotifier {
  final SharedPrefsUserRepository userRepository;

  String? email;
  String? password;

  UserState(this.userRepository);

  Future<void> loadUserData() async {
    final data = await userRepository.getUserData();
    email = data['email'];
    password = data['password'];
    notifyListeners();
  }

  Future<void> saveUserData(String email, String password) async {
    await userRepository.saveUserData(email, password);
    this.email = email;
    this.password = password;
    notifyListeners();
  }

  Future<void> clearUserData() async {
    await userRepository.clearUserData();
    email = null;
    password = null;
    notifyListeners();
  }

  Future<void> updateEmail(String newEmail) async {
    await userRepository.updateEmail(newEmail);
    email = newEmail;
    notifyListeners();
  }
}
