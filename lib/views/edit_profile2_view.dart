import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_first_app/controllers/edit_profile2_controller.dart';

class EditProfile2View extends GetView<EditProfile2Controller> {
  const EditProfile2View({super.key});

  // Reusable decoration: Keeps ALL icons INSIDE the text box borders!
  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: hint,
      prefixIcon: Icon(icon, color: Colors.grey[700]),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFCC5500), width: 1.5),
      ),
    );
  }

  void _showImageSourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickProfileImage(ImageSource.camera); // ◄── Triggers Camera
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  controller.pickProfileImage(ImageSource.gallery); // ◄── Triggers Gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.editFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  
                  // Profile Avatar
                  Center(
                    child: GestureDetector(
                      onTap: () => _showImageSourceSheet(context),
                      child: Stack(
                        children: [
                          Obx(() {
                            final imagePath = controller.profileImage.value;
                            return CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: imagePath.isEmpty
                                  ? null
                                  : FileImage(File(imagePath)),
                              child: imagePath.isEmpty
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.grey[600],
                                    )
                                  : null,
                            );
                          }),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Color(0xFFCC5500),
                              child: Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Full Name
                  TextFormField(
                    controller: controller.fullNameController,
                    keyboardType: TextInputType.name,
                    decoration: _inputDecoration(
                      hint: 'Full Name',
                      icon: Icons.person,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(
                      hint: 'Email Address',
                      icon: Icons.email_outlined,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  //  Gender Dropdown
                  Obx(() => DropdownButtonFormField<String>(
                        initialValue: controller.gender.value.isNotEmpty
                            ? controller.gender.value
                            : null,
                        decoration: _inputDecoration(
                          hint: 'Gender',
                          icon: Icons.wc,
                        ),
                        hint: const Text('Select Gender'),
                        items: controller.genderOptions.map((option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateGender(value);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your gender';
                          }
                          return null;
                        },
                      )),

                  const SizedBox(height: 16),

                  //  Phone Number
                  TextFormField(
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration(
                      hint: 'Phone Number',
                      icon: Icons.phone,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  //  Date of Birth Picker
                  InkWell(
                    onTap: () => controller.pickDateOfBirth(context),
                    child: IgnorePointer(
                      child: Obx(() => TextFormField(
                            key: ValueKey(controller.birthDate.value),
                            initialValue: controller.birthDate.value,
                            decoration: _inputDecoration(
                              hint: 'Date of Birth (dd/MM/yyyy)',
                              icon: Icons.calendar_today,
                            ),
                            validator: (value) {
                              if (controller.birthDate.value.isEmpty) {
                                return 'Please select your date of birth';
                              }
                              return null;
                            },
                          )),
                    ),
                  ),

                  const SizedBox(height: 16),

                  //  Bio
                  TextFormField(
                    controller: controller.bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      alignLabelWithHint: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 36),
                        child: Icon(Icons.info_outline, color: Colors.grey[700]),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFCC5500), width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a short bio';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Save Button
                  Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCC5500),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: controller.isSaving.value
                          ? null
                          : () => controller.saveProfile(),
                      child: controller.isSaving.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Save Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}