import 'package:flutter/material.dart';
import 'package:my_project/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // конструктор з ключем

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // ширина екрану

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login', // заголовок екрану
          style: pinkBoldTextStyle(screenWidth * 0.06), // стиль тексту
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // центруємо контент
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email', // підказка для email
                labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
              ),
            ),
            SizedBox(height: screenWidth * 0.05), // відступ між полями
            TextField(
              decoration: InputDecoration(
                labelText: 'Password', // підказка для пароля
                labelStyle: pinkBoldTextStyle(screenWidth * 0.045),
              ),
              obscureText: true, // приховуємо пароль
            ),
            SizedBox(height: screenWidth * 0.1), // великий відступ
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home'); // на головну
              },
              child: Text(
                'Login', // текст кнопки
                style: pinkBoldTextStyle(screenWidth * 0.05),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // перехід на реєстрацію
              },
              child: Text(
                "Don't have an account? Register", // текст підказки
                style: pinkBoldTextStyle(screenWidth * 0.04),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
