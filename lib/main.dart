import 'package:flutter/material.dart';
import 'repository/shared_prefs_user_repository.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SharedPrefsUserRepository userRepository = SharedPrefsUserRepository();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(userRepository: userRepository),
        '/register': (context) => RegistrationScreen(
          userRepository: userRepository,
          onRegisterSuccess: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        '/home': (context) => HomeScreen(userRepository: userRepository),
        '/profile': (context) => ProfileScreen(
          userRepository: userRepository,
          onDeleteAccount: () async {
            await userRepository.clearUserData();
            Navigator.pushReplacementNamed(context, '/');
          },
          onEditEmail: (newEmail) async {
            await userRepository.updateEmail(newEmail);
            Navigator.pop(context);
          },
        ),
      },
    );
  }
}
