import 'package:flutter/material.dart';
import 'package:my_project/styles.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void _submitData() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty || !email.contains('@')) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error', style: pinkBoldTextStyle(18)),
          content: Text('Please enter valid data.', style: pinkBoldTextStyle(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: pinkBoldTextStyle(16)),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Submitted Data', style: pinkBoldTextStyle(18)),
          content: Text('Name: $name\nEmail: $email', style: pinkBoldTextStyle(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK', style: pinkBoldTextStyle(16)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen', style: pinkBoldTextStyle(screenWidth * 0.06)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Submit', style: pinkBoldTextStyle(screenWidth * 0.05)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
