import 'dart:async';
import 'package:flutter/material.dart';
import 'profile_screen.dart';

// StatefulWidget to do the 3 seconds delay before navigating to the profile
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // call the start time function.
    _startTimer();
  }

  void _startTimer() {
    Timer(const Duration(seconds: 3), () {
    
      setState(() {
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //calls the profile screen class in profile_screen.dart
            builder: (context) => const ProfileScreen()
          ),
        );
      });
    });
  }
  @override
  // building the wideget that will contain the splash screen layout and design
  // this widget will go after 3 seconds.
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset(
                'assets/images/chef.jpg',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
             const SizedBox(height: 16),
              // App Title
              Text(
                'Product-List-Cart',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(flex: 3),
              // Loading Indicator placeholder at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 45.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFA5A5A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}