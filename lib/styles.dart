import 'package:flutter/material.dart';

// Рожевий жирний текст
TextStyle pinkBoldTextStyle(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.pink,
  );
}

// Звичайний чорний текст
TextStyle blackRegularTextStyle(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    color: Colors.black,
  );
}

// Сірий текст для підказок
TextStyle greyHintTextStyle(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    color: Colors.grey,
    fontStyle: FontStyle.italic,
  );
}

// Стиль кнопки
ButtonStyle pinkButtonStyle(double paddingHorizontal, double paddingVertical) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.pink,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: paddingHorizontal,
      vertical: paddingVertical,
    ),
  );
}