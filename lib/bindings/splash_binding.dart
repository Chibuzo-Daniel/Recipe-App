import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    //calls the splash controller into the memory when the page is active
    Get.put<SplashController>(SplashController());
  }
}
