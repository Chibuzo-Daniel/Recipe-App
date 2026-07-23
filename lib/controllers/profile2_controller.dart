import 'package:get/get.dart';
import '../../storage/service_storage.dart';
import '../../routes/app_routes.dart'; 

class Profile2Controller extends GetxController {
  final ServiceStorage _serviceStorage = Get.find<ServiceStorage>();

  final userName = ''.obs;
  final userEmail = ''.obs;
  final gender = ''.obs;
  final phoneNumber = ''.obs;
  final bio = ''.obs;
  final dateOfBirth = ''.obs;
  final profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  // Called whenever profile view appears or returns from edit screen
  void loadProfileData() {
    userName.value = _serviceStorage.getUserName();
    userEmail.value = _serviceStorage.getUserEmail();
    gender.value = _serviceStorage.getGender();
    phoneNumber.value = _serviceStorage.getPhoneNumber();
    bio.value = _serviceStorage.getBio();
    dateOfBirth.value = _serviceStorage.getDateOfBirth();
    profileImagePath.value = _serviceStorage.getProfileImagePath();
  }

  void logout() async {
    await _serviceStorage.clearSession();
    Get.offAllNamed(AppRoutes.login); 
  }
}