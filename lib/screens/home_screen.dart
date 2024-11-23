import 'package:flutter/material.dart';
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
  }

  Future<void> _loadUserData() async {
    final userData = await widget.userRepository.getUserData();
    setState(() {
      email = userData['email'] ?? 'No email found';
    });
  }

  Future<void> _logout() async {
    await widget.userRepository.clearUserData();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _logout();
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              await Navigator.pushNamed(context, '/profile');
              // Після повернення з профілю оновлюємо дані
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
