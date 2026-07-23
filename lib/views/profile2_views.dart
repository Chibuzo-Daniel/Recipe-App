import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile2_controller.dart';
import '../../routes/app_routes.dart'; // Adjust import to your routes path

class Profile2View extends StatelessWidget {
  const Profile2View({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Profile2Controller());
    controller.loadProfileData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color:  Color(0xFFCC5500),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
       
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 1. Minimal Profile Avatar
              Obx(() {
                final path = controller.profileImagePath.value;
                return CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      path.isNotEmpty ? FileImage(File(path)) : null,
                  child: path.isEmpty
                      ? const Icon(Icons.person_outline, size: 55, color: Color(0xFFCC5500))
                      : null,
                );
              }),

              const SizedBox(height: 16),

              // 2. Full Name
              Obx(() => Text(
                    controller.userName.value.isNotEmpty
                        ? controller.userName.value
                        : 'No name set',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )),

              const SizedBox(height: 4),

              // Email
              Obx(() => Text(
                    controller.userEmail.value.isNotEmpty
                        ? controller.userEmail.value
                        : 'No email set',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  )),

              const SizedBox(height: 24),

              //  Details Card (Phone, DOB, Bio)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Phone Number
                    Obx(() => _buildDetailRow(
                          icon: Icons.phone_outlined,
                          title: 'Phone',
                          value: controller.phoneNumber.value,
                          
                        )),

                    const Divider(height: 24, thickness: 0.8),

                    // Date of Birth
                    Obx(() => _buildDetailRow(
                          icon: Icons.calendar_today_outlined,
                          title: 'Date of Birth',
                          value: controller.dateOfBirth.value,
                        )),

                    const Divider(height: 24, thickness: 0.8),

                    // Bio
                    Obx(() => _buildDetailRow(
                          icon: Icons.info_outline,
                          title: 'Bio',
                          value: controller.bio.value,
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 5. Outline Edit Profile Button (matching screenshot pill design)
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () async {
                  await Get.toNamed(AppRoutes.editProfile2);
                  controller.loadProfileData();
                },
                icon: const Icon(Icons.edit, size: 16, color: Color(0xFFCC5500)),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(
                   color: Color(0xFFCC5500),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Row helper for clean minimalist details card
  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'Not set',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}