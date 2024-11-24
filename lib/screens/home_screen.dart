import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../repository/shared_prefs_user_repository.dart';

class HomeScreen extends StatefulWidget {
  final SharedPrefsUserRepository userRepository;

  const HomeScreen({
    required this.userRepository,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _monitorConnectivity();
  }

  Future<void> _loadUserData() async {
    final userData = await widget.userRepository.getUserData();
    setState(() {
      email = userData['email'] ?? 'No email found';
    });
  }

  void _monitorConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _showDialog('No internet connection. Limited functionality.');
      }
    });
  }

  Future<void> _logout() async {
    final confirmed = await _confirmLogout();
    if (confirmed) {
      await widget.userRepository.clearUserData();
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> _showDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _confirmLogout() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Log out'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    // Переконаємось, що значення не null, і якщо воно null, повернемо false
    return result ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              await Navigator.pushNamed(context, '/profile');
              await _loadUserData();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Email: $email'),
      ),
    );
  }
}
