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
    // Валідація імейлу через регулярний вираз
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email updated to $newEmail')),
                    );
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to update email. Try again.'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid email')),
                  );
                }
              },
              child: const Text('Update Email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await onDeleteAccount();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account deleted successfully'),
                    ),
                  );
                  Navigator.pushReplacementNamed(context, '/');
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to delete account. Try again.'),
                    ),
                  );
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
