import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../repository/user_repository.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key, required this.userRepository}) : super(key: key);

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
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final connectivityResult =
                await Connectivity().checkConnectivity();
                if (connectivityResult == ConnectivityResult.none) {
                  await _showDialog(context,
                      'No internet connection. Please reconnect.');
                  return;
                }

                final userData = await userRepository.getUserData();
                if (emailController.text == userData['email'] &&
                    passwordController.text == userData['password']) {
                  Navigator.pushReplacementNamed(context, '/home');
                  await _showDialog(context, 'Login successful!');
                } else {
                  await _showDialog(context, 'Invalid email or password.');
                }
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Don’t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}