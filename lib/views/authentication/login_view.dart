import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'package:my_first_app/controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>
              Get.back(), // uses GetX back navigation instead of Navigator
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          // Now using  a Form widget to build the input fields
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // page image
                Center(
                  child: Image.network(
                    'https://i.pinimg.com/webp85/736x/6b/65/41/6b6541cf791ecf8680de60f51e44e95f.webp',
                    width: 90,
                    height: 90,
                  ),
                ),
                const SizedBox(height: 50),

                // Email or phone input field
                _buildFormInputField(
                  label: 'PHONE OR EMAIL',
                  hint: 'Enter your phone number or email address',
                  fieldController: controller.emailController,

                  //use validator to check if the user input is valid
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone or email';
                    }

                    String emailPattern =
                        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                    RegExp regExp = RegExp(emailPattern);

                    if (!regExp.hasMatch(value.trim())) {
                      return 'Please enter a valid email address format';
                    }

                    return null;
                  },
                ),

                // Password input field
                Obx(
                  () => _buildFormInputField(
                    label: 'PASSWORD',
                    hint: 'Enter your password',
                    fieldController: controller.passwordController,
                    isPassword: true,
                    obscureText: controller.isPasswordHidden.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color.fromARGB(255, 54, 54, 54),
                      ),
                      onPressed: () => controller.togglePasswordVisibility(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),

                // Route to Registration page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "don't have an account? ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 58, 57, 57),
                        fontSize: 13,
                      ),
                    ),
                    GestureDetector(
                      // navigate to the registration page
                      onTap: () => Get.toNamed(AppRoutes.register),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFFCC5500),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 110),

                // login button
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCC5500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    onPressed: () {
                      // call the login function
                      controller.login();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // widget builder for the text form field
  Widget _buildFormInputField({
    required String label,
    required String hint,
    required TextEditingController fieldController,
    required FormFieldValidator<String> validator,
    bool isPassword = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 124, 123, 123),
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: fieldController,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 94, 92, 92),
                fontSize: 14,
              ),
              suffixIcon: isPassword ? suffixIcon : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 182, 180, 180),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Color(0xFFCC5500)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
