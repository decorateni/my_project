import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/shared_prefs_user_repository.dart';
import 'services/api_service.dart';
import 'state/user_state.dart';
import 'state/movie_state.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/no_internet_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPrefsUserRepository userRepository = SharedPrefsUserRepository();
  final ApiService apiService = ApiService();
  final bool autoLogin = await _checkAutoLogin(userRepository);

  runApp(MyApp(
    userRepository: userRepository,
    apiService: apiService,
    autoLogin: autoLogin,
  ));
}

Future<bool> _checkAutoLogin(SharedPrefsUserRepository userRepository) async {
  final userData = await userRepository.getUserData();
  return userData['email'] != null && userData['password'] != null;
}

class MyApp extends StatelessWidget {
  final SharedPrefsUserRepository userRepository;
  final ApiService apiService;
  final bool autoLogin;

  const MyApp({
    required this.userRepository,
    required this.apiService,
    required this.autoLogin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserState(userRepository)),
        ChangeNotifierProvider(create: (_) => MovieState(apiService)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: autoLogin ? '/home' : '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(
            onRegisterSuccess: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(
            userRepository: userRepository, // Ось тут виправлено
            onDeleteAccount: () async {
              await context.read<UserState>().clearUserData();
              Navigator.pushReplacementNamed(context, '/');
            },
            onEditEmail: (newEmail) async {
              await context.read<UserState>().updateEmail(newEmail);
              Navigator.pop(context);
            },
          ),
          '/no_internet': (context) => NoInternetScreen(),
        },
      ),
    );
  }
}
