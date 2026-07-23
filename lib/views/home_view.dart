import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_first_app/views/profile2_views.dart';
//import 'package:my_first_app/views/profile_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget _buildRecipeListTab() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // app bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Recipes',
          style: TextStyle(
            color: Color(0xFFCC5500),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        // when the app is loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFCC5500)),
          );
        }

        // error state with retry button whe the recipe couldn't fetch
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCC5500),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // retry button to fetch the recipes again
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFCC5500),
                    ),
                    onPressed: () => controller.fetchRecipes(),
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // if the api returns an empty list
        if (controller.recipes.isEmpty) {
          return const Center(
            child: Text(
              'No recipes found',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // the home UI
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.recipes.length,
          itemBuilder: (context, index) {
            final recipe = controller.recipes[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 112, 112, 112),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Recipe Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    child: Image.network(
                      recipe.image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                            width: 110,
                            height: 110,
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                    ),
                  ),
                  // Recipe Information
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            recipe.cuisine,
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              // Difficulty Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE2F6F9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  recipe.difficulty,
                                  style: const TextStyle(
                                    color: Color(0xFFCC5500),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              // Cooking Time Information
                              Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${recipe.cookTimeMinutes}m',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(width: 3),
                              // Star Rating Infoormation
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Color(0xFFCC5500),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${recipe.rating}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),

        // screen content for the bottom navigation bar
        body: IndexedStack(
          index: controller.currentTab.value,
          children: [
            _buildRecipeListTab(),
            _buildPlaceholderTab(Icons.shopping_cart, 'Cart'),
            Profile2View(),
            _buildPlaceholderTab(Icons.notifications, 'Notifications'),
            _buildPlaceholderTab(Icons.settings, 'Settings'),
          ],
        ),

        // bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentTab.value,
          onTap: (index) => controller.changeTab(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFCC5500),

          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      );
    });
  }

  // widget builder for the placeholder tab
  Widget _buildPlaceholderTab(IconData iconData, String title) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, size: 64, color: const Color(0xFFCC5500)),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCC5500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
