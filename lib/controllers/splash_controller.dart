import 'package:get/get.dart';
import '../routes/app_routes.dart';
import 'dart:async';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _startInitialCountdown();
  }

  void _startInitialCountdown() {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.onboarding);
    });
  }
}
