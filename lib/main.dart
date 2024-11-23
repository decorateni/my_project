import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/third_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 3',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Arial',
            fontSize: 16,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Arial',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.pink,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    );
  }
}
