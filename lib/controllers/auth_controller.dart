import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  // global Keys to access the form fields
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text Editing Controllers to listen to inputs
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final birthdayController = TextEditingController();

  // Observables to track changes
  var isPasswordHidden = true.obs;

  final userName = ''.obs;
  final userEmail = ''.obs;
  final isRegisteredUser = false.obs;

  // Toggle password visibility with the eye icon
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Login function
  void login() {
    if (loginFormKey.currentState!.validate()) {
      // Save the email if user is from login page
      userEmail.value = emailController.text.trim();
      userName.value = 'Visitor';
      isRegisteredUser.value = false;

      // Navigate to home
      Get.offAllNamed(AppRoutes.home);
    }
  }

  // Registration function
  void register() {
    if (registerFormKey.currentState!.validate()) {
      // Save the name and email they typed during registration
      userName.value = nameController.text.trim();
      userEmail.value = emailController.text.trim();
      isRegisteredUser.value = true;

      // Navigate to home
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void onClose() {
    // Clean up text field controllers when the controller is destroyed
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    super.onClose();
  }
}
