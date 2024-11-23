import 'package:flutter/material.dart';
import 'package:my_project/styles.dart'; // стилі для тексту

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // конструктор з ключем

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // ширина екрана

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home', // заголовок екрану
          style: pinkBoldTextStyle(screenWidth * 0.06), // рожевий жирний стиль
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // центруємо все
          children: [
            Text(
              'Welcome to the App', // привітання
              style: pinkBoldTextStyle(screenWidth * 0.06), // стиль тексту
            ),
            SizedBox(height: screenWidth * 0.1), // відступ
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile'); // на профіль
              },
              child: Text(
                'Go to Profile', // текст на кнопці
                style: pinkBoldTextStyle(screenWidth * 0.05), // стиль кнопки
              ),
            ),
          ],
        ),
      ),
    );
  }
}
