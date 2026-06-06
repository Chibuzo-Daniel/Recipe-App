import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const CookpediaApp());
}

class CookpediaApp extends StatelessWidget {
  const CookpediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookpedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

      ),
      // Set the start screen to the Splash Screen
      home: const SplashScreen(),
    );
  }
}