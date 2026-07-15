import 'package:get/get.dart';
import 'package:my_first_app/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // when the user gets to authentication page, the bindimg calls the authenctication controller
    Get.put(AuthController(), permanent: true);
  }
}
