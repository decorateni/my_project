import 'package:flutter/material.dart';
import 'repository/shared_prefs_user_repository.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/no_internet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPrefsUserRepository userRepository = SharedPrefsUserRepository();
  final bool autoLogin = await _checkAutoLogin(userRepository);

  runApp(MyApp(
    userRepository: userRepository,
    autoLogin: autoLogin,
  ));
}

Future<bool> _checkAutoLogin(SharedPrefsUserRepository userRepository) async {
  final userData = await userRepository.getUserData();
  return userData['email'] != null && userData['password'] != null;
}

class MyApp extends StatelessWidget {
  final SharedPrefsUserRepository userRepository;
  final bool autoLogin;

  MyApp({required this.userRepository, required this.autoLogin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: autoLogin ? '/home' : '/',
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
        '/no_internet': (context) => NoInternetScreen(),
      },
    );
  }
}