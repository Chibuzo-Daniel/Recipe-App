import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Brand Orange Constant
    const brandOrange = Color(0xFFCC5500);

    // Dynamically retrieve the AuthController holding our logged-in user's inputs!
    final AuthController authController = Get.find<AuthController>();

    // assuming all user came from login if the registration name controller is empty
    final bool isFromLogin = !authController.isRegisteredUser.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: brandOrange,
        backgroundColor: Colors.white,
        elevation: 3,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: brandOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            // ◄── COLOR UPDATED: App Bar Action Icon
            icon: const Icon(Icons.more_horiz, color: brandOrange),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Profile stats row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      'https://images.stockcake.com/public/5/5/a/55aa0081-3d0d-495b-b649-4838f12aedd3_large/professional-young-man-stockcake.jpg',
                    ),
                  ),
                  const Spacer(),
                  _buildStatColumn('Recipe', '4'),
                  const Spacer(),
                  _buildStatColumn('Followers', '2.5M'),
                  const Spacer(),
                  _buildStatColumn('Following', '259'),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 16),

              // using observable to update ui
              Obx(
                () => Text(
                  isFromLogin
                      ? "Hello, ${authController.userName.value}"
                      : "Welcome, ${authController.userName.value}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Obx(
                () => Text(
                  authController.userEmail.value,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),

              const SizedBox(height: 12),
              const Text(
                'Active Chef\nI cook to live and live to cook 🍲👌',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Text(
                'More...',
                style: TextStyle(
                  color: brandOrange,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              
              // Horizontal Category Switcher
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: brandOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Recipe',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Videos',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tag',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // product list
              Obx(
                () => Column(
                  children: [
                    _buildRecipeCard(
                      'Panna Cotta',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-baklava-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Brownie',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-brownie-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Strawberry Cake',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-cake-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Creme Brulee',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-creme-brulee-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Macaron',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-macaron-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Panna Cotta',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-meringue-mobile.jpg',
                    ),
                    const SizedBox(height: 16),
                    _buildRecipeCard(
                      'Panna Cotta',
                      'Chef ${authController.userName.value}',
                      '4.0',
                      '20 min',
                      'assets/images/image-panna-cotta-mobile.jpg',
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // widget builder for the profile info
  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // widget builder for the recipe card
  Widget _buildRecipeCard(
    String title,
    String author,
    String rating,
    String duration,
    String imageUrl,
  ) {
    const brandOrange = Color(0xFFCC5500);

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // ◄── COLOR UPDATED: Rating Star Icon
                  const Icon(Icons.star, color: brandOrange, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By $author',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // ◄── COLOR UPDATED: Time Duration Icon
                    const Icon(
                      Icons.access_time,
                      color: brandOrange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    
                    // ◄── COLOR UPDATED: Bookmark Circle & Icon
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.bookmark_border,
                        color: brandOrange,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}