import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/user_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text('Login')),
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
                final userState = context.read<UserState>();
                final userData = await userState.userRepository.getUserData();

                if (emailController.text == userData['email'] &&
                    passwordController.text == userData['password']) {
                  Navigator.pushReplacementNamed(context, '/home');
                  await _showDialog(context, 'Login successful!');
                } else {
                  await _showDialog(context, 'Invalid email or password.');
                }
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Don’t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}
