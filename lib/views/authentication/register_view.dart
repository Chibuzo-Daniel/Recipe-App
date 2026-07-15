import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //app bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Register',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // Uses GetX to go back to Login
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            // registration form key for validatiion
            key: controller.registerFormKey,
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      //image
                      Image.network(
                        'https://i.pinimg.com/webp85/736x/6b/65/41/6b6541cf791ecf8680de60f51e44e95f.webp',

                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(height: 5),

                      // name field
                      _buildFormInputField(
                        label: 'NAME',
                        hint: 'Enter your full name',
                        fieldController: controller.nameController,
                        // name validator
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      // email field
                      _buildFormInputField(
                        label: 'EMAIL',
                        hint: 'Enter your phone or email',
                        fieldController: controller.emailController,
                        // email validator
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          //using reg expression too validate email
                          String emailPattern =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}';
                          if (!RegExp(emailPattern).hasMatch(value.trim())) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),

                      // password field
                      Obx(
                        () => _buildFormInputField(
                          label: 'PASSWORD',
                          hint: 'Create a password',
                          fieldController: controller.passwordController,
                          isPassword: true,
                          obscureText: controller.isPasswordHidden.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordHidden.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: controller.isPasswordHidden.value
                                  ? Colors.grey
                                  : Colors.grey,
                            ),
                            onPressed: () =>
                                controller.togglePasswordVisibility(),
                          ),
                          // password validator
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please create a password';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),

                      // confirm password field
                      Obx(
                        () => _buildFormInputField(
                          label: 'CONFIRM PASSWORD',
                          hint: 'Re-enter your password',
                          fieldController: controller.confirmPasswordController,
                          isPassword: true,
                          obscureText: controller.isPasswordHidden.value,
                          suffixIcon: Icon(
                            Icons.lock_outline,
                            color: controller.isPasswordHidden.value
                                ? Colors.grey[400]
                                : Colors.grey[400],
                          ),
                          // confirm password validator
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please re-enter your password';
                            }

                            //passwords match verification
                            if (value.trim() !=
                                controller.passwordController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),

                      // birth date field
                      _buildFormInputField(
                        label: 'BIRTH DATE',
                        hint: 'Enter your birth date',
                        fieldController: controller.birthdayController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your birth date';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      // registartion button
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCC5500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: () {
                            // check if all field passed the validation
                            controller.register();
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 87, 86, 86),
            ),
          ),
          const SizedBox(height: 3),
          TextFormField(
            controller: fieldController,
            obscureText: obscureText,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color.fromARGB(255, 53, 53, 53),
                fontSize: 13,
              ),
              suffixIcon: isPassword ? suffixIcon : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(color: Colors.grey[500]!),
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
