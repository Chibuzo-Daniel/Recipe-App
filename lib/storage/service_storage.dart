import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceStorage extends GetxService {
  late SharedPreferences _preferences;

  Future<ServiceStorage> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  bool getIsFirstTime() {
    return _preferences.getBool('is_first_time') ?? true;
  }

  Future<void> setIsFirstTime(bool value) async {
    await _preferences.setBool('is_first_time', value);
  }

  bool isLoggedIn() {
    return _preferences.getString('auth_token') != null;
  }

  String getUserName() {
    return _preferences.getString('user_name') ?? '';
  }

  String getUserEmail() {
    return _preferences.getString('user_email') ?? '';
  }

  Future<void> saveSession({
    required String token,
    required String name,
    required String email,
  }) async {
    await _preferences.setString('auth_token', token);
    if (getUserName().isEmpty) {
      await _preferences.setString('user_name', name);
    }
    if (getUserEmail().isEmpty) {
      await _preferences.setString('user_email', email);
    }
  }

  Future<void> clearSession() async {
    await _preferences.remove('auth_token');
   
  }

  // --- Editable profile fields (profile2 module) ---
  // There is no backend endpoint for updating a profile, so every field
  // below is persisted straight to SharedPreferences and read back to
  // render the profile screen.

  String getGender() => _preferences.getString('profile_gender') ?? '';

  String getPhoneNumber() => _preferences.getString('profile_phone') ?? '';

  String getBio() => _preferences.getString('profile_bio') ?? '';

  String getDateOfBirth() => _preferences.getString('profile_dob') ?? '';

  String getProfileImagePath() =>
      _preferences.getString('profile_image_path') ?? '';

  Future<void> saveProfileDetails({
    required String fullName,
    required String gender,
    required String phoneNumber,
    required String bio,
    required String dateOfBirth,
    required String profileImagePath,
    required String email
  }) async {
    await _preferences.setString('user_name', fullName);
    await _preferences.setString('profile_gender', gender);
    await _preferences.setString('profile_phone', phoneNumber);
    await _preferences.setString('profile_bio', bio);
    await _preferences.setString('profile_dob', dateOfBirth);
    await _preferences.setString('profile_image_path', profileImagePath);
    await _preferences.setString('user_email', email);
  }
}
