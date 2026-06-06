import 'package:flutter/material.dart';

// StatelessWidget used as requested for the static Profile view layout structure
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  //this is the parent widget housing all the visible component of the profile screen.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
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
              // Profile picture and details
              Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
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
              // User Information
              const Text(
                'Chibuzo Daniel Onyedikachukwu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Chef',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 12),
              const Text(
                'Active Chef\nI cook to live and live to cook😂😋🍲',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Text(
                'More...',
                style: TextStyle(color: Color(0xFF0C9B72), fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              // Dummy navigation buttons (Recipe, Videos, Tag)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0C9B72), // Emerald Green
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Recipe',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Videos',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Tag',
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recipe details 

              _buildRecipeCard(
                'Brownie',
                'Chef Daniel',
                '4.0',
                '20 min',
                 'assets/images/image-brownie-mobile.jpg',
              ),
              const SizedBox(height: 16),
              _buildRecipeCard(
                'Strawberry Cake',
                'Chef Daniel',
                '4.0',
                '20 min',
                'assets/images/image-cake-mobile.jpg',
              ),
              const SizedBox(height: 16),
              _buildRecipeCard(
                'Creme Brulee',
                'Chef Daniel',
                '4.0',
                '20 min',
                'assets/images/image-creme-brulee-mobile.jpg',
              ),
              const SizedBox(height: 16),
              _buildRecipeCard(
                'Macaron',
                'Chef Daniel',
                '4.0',
                '20 min',
                'assets/images/image-macaron-mobile.jpg',
              ),
              const SizedBox(height: 16),
              _buildRecipeCard(
                'Panna Cotta',
                'Chef Daniel',
                '4.0',
                '20 min',
                'assets/images/image-panna-cotta-mobile.jpg',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // widget builder for the  (Recipe, Followers, Following numbers)
  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

 // widget builder for the recipe cards.
Widget _buildRecipeCard(String title, String author, String rating, String duration, String imageUrl) {
  return Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(24),
      image: DecorationImage(
      
        image: AssetImage(imageUrl), 
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        // Styling the card overlay
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
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
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        //arranging the content of the overlay.
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
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'By $author',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    duration,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: const Icon(Icons.bookmark_border, color: Colors.white, size: 18),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
}