import 'package:flutter/material.dart';
import '../repository/shared_prefs_user_repository.dart';

class ProfileScreen extends StatelessWidget {
  final SharedPrefsUserRepository userRepository;
  final Future<void> Function() onDeleteAccount;
  final Future<void> Function(String newEmail) onEditEmail;

  const ProfileScreen({
    required this.userRepository,
    required this.onDeleteAccount,
    required this.onEditEmail,
    Key? key,
  }) : super(key: key);

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

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
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'New Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newEmail = emailController.text.trim();
                if (_isValidEmail(newEmail)) {
                  try {
                    await onEditEmail(newEmail);
                    await _showDialog(context, 'Email updated to $newEmail');
                  } catch (error) {
                    await _showDialog(
                        context, 'Failed to update email. Try again.');
                  }
                } else {
                  await _showDialog(context, 'Please enter a valid email.');
                }
              },
              child: const Text('Update Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await onDeleteAccount();
                  await _showDialog(context, 'Account deleted successfully');
                  Navigator.pushReplacementNamed(context, '/');
                } catch (error) {
                  await _showDialog(
                      context, 'Failed to delete account. Try again.');
                }
              },
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
