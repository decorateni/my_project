import 'package:flutter/material.dart';
import '../repository/shared_prefs_user_repository.dart';

class RegistrationScreen extends StatelessWidget {
  final SharedPrefsUserRepository userRepository;
  final VoidCallback onRegisterSuccess;

  RegistrationScreen({
    required this.userRepository,
    required this.onRegisterSuccess,
    Key? key,
  }) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _showDialog(BuildContext context, String message) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isNotEmpty &&
                    password.isNotEmpty &&
                    email.contains('@') &&
                    password.length >= 8) {
                  await userRepository.saveUserData(email, password);
                  await _showDialog(context, 'Registration successful!');
                  onRegisterSuccess();
                } else {
                  await _showDialog(
                      context,
                      'Please enter a valid email and password (8+ characters).');
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
