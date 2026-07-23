import 'package:get/get.dart';
import '../controllers/edit_profile2_controller.dart';

class EditProfile2Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfile2Controller>(
      () => EditProfile2Controller(),
    );
  }
}