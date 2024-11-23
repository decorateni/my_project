import 'package:flutter/material.dart';
import 'package:my_project/styles.dart'; // стилі для рожевого тексту

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key}); // конструктор

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // ширина екрану

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registration', // заголовок екрану
          style: pinkBoldTextStyle(screenWidth * 0.06), // рожевий жирний стиль
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // центруємо все
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email', // поле для email
                labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password', // поле для пароля
                labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
              ),
              obscureText: true, // приховано
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm Password', // підтвердження пароля
                labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
              ),
              obscureText: true,
            ),
            SizedBox(height: screenWidth * 0.1),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // переходимо на головну
              },
              child: Text(
                'Register', // кнопка для реєстрації
                style: pinkBoldTextStyle(screenWidth * 0.05), // стиль кнопки
              ),
            ),
          ],
        ),
      ),
    );
  }
}
