import 'package:flutter/material.dart';
import 'package:my_project/styles.dart'; // стилі для тексту

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key}); // конструктор із ключем

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // ширина екрану

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile', // заголовок екрану
          style: pinkBoldTextStyle(screenWidth * 0.06), // рожевий стиль
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // центруємо контент
          children: [
            CircleAvatar(
              radius: screenWidth * 0.2, // розмір аватарки
              backgroundColor: Colors.blueAccent, // фон для аватарки
              child: Icon(
                Icons.person, // іконка користувача
                size: screenWidth * 0.2, // розмір іконки
                color: Colors.white, // колір іконки
              ),
            ),
            SizedBox(height: screenWidth * 0.05), // відступ
            Text(
              'User Name', // ім'я користувача
              style: pinkBoldTextStyle(screenWidth * 0.06), // стиль тексту
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              'user@example.com', // email користувача
              style: pinkBoldTextStyle(screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.1), // відступ
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // назад на попередній екран
              },
              child: Text(
                'Logout', // кнопка для виходу
                style: pinkBoldTextStyle(screenWidth * 0.05), // стиль кнопки
              ),
            ),
          ],
        ),
      ),
    );
  }
}
