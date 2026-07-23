import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/storage/service_storage.dart';
import 'package:intl/intl.dart';

class EditProfile2Controller extends GetxController {
  final ServiceStorage _serviceStorage = Get.find<ServiceStorage>();
  
  final ImagePicker _imagePicker = ImagePicker();
  final editFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController();
  

  final gender = ''.obs;
  final birthDate = ''.obs;
  final profileImage = ''.obs;
  final  email = ''.obs;
  final isSaving = false.obs;

  final genderOptions = ['Male', 'Female'];
@override
  onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    // Load profile data from storage or API
    fullNameController.text = _serviceStorage.getUserName();
    emailController.text = _serviceStorage.getUserEmail();
    phoneNumberController.text = _serviceStorage.getPhoneNumber();
    bioController.text = _serviceStorage.getBio();
    gender.value = _serviceStorage.getGender();
    birthDate.value = _serviceStorage.getDateOfBirth();
    profileImage.value = _serviceStorage
        .getProfileImagePath(); // Load profile image path if available
  }

  void updateGender(String? value) => gender.value = value ?? '';

 Future<void> pickProfileImage(ImageSource source) async {
  try {
    final pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      profileImage.value = pickedFile.path;
    }
  } catch (e) {
    Get.snackbar(
      'Permission Error',
      'Please allow camera/gallery permissions in your device settings.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.red,
    );
  }
}

  ImageProvider? profileImageProvider(String path) {
    if (path.isEmpty) return null;
      return FileImage(File(path));
  }

  // Implement the date of birth picker logic here, similar to the profile image picker.
  Future<void> pickDateOfBirth(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: birthDate.value.isNotEmpty 
          ? DateFormat('dd/MM/yyyy').parse(birthDate.value) 
          : DateTime.now(),
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      birthDate.value = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  Future<void> saveProfile() async {
    if (editFormKey.currentState?.validate() ?? false) {
      isSaving.value = true;
      var saved = false;

      try {
        await _serviceStorage.saveProfileDetails(
          fullName: fullNameController.text,
          gender: gender.value,
          phoneNumber: phoneNumberController.text,
          bio: bioController.text,
          dateOfBirth: birthDate.value,
          profileImagePath: profileImage.value,
          email: emailController.text,
        );
        saved = true;
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to save profile: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isSaving.value = false;
      }

      if (saved) {
        Get.back(result: true);
      }
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
