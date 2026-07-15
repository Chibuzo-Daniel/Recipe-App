import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  // widget builder for the splash screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            // splash screen network image
            Image.network(
              'https://i.pinimg.com/webp85/736x/6b/65/41/6b6541cf791ecf8680de60f51e44e95f.webp',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),

            //App Title
            const Text(
              'Recipe List',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCC5500),
              ),
            ),

            const Spacer(flex: 3),

            const Padding(
              padding: EdgeInsets.only(bottom: 45),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFCC5500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
