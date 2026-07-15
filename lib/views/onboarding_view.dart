import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    // content of each slide

    final List<Map<String, String>> onboadingContent = [
      {
        'title': 'Welcome to Recipe List',
        'description':
            'All we do here is to make you enjoy your living like never before 😂',
        'image':
            'https://i.pinimg.com/1200x/05/81/9e/05819e1cc35e22c3c5e6bc8f569f7830.jpg',
      },
      {
        'title': 'Freshness overload',
        'description':
            ' Everything is fresh and clean, so you can enjoy our recipe without worrying about the cleanliness of the kitchen',
        'image':
            'https://i.pinimg.com/736x/30/a2/a7/30a2a709f49e7ca462f82c67f79db1d6.jpg',
      },
      {
        'title': 'Trust us!!!',
        'description': 'If it is not fresh or sweet, we will refund you 🙄',
        'image':
            'https://i.pinimg.com/736x/b0/f1/a2/b0f1a2358eb1697eac7e924a2ef034fa.jpg',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: controller.pageController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: controller.updatePage,
                itemCount: onboadingContent.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Image.network(
                          // onboarding image
                          onboadingContent[index]['image']!,
                          height: 200,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 32),
                        // onboarding tittle
                        Text(
                          onboadingContent[index]['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCC5500),
                          ),
                        ),
                        const SizedBox(height: 16),
                        //onboarding description
                        Text(
                          onboadingContent[index]['description'] ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 124, 124, 124),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // the bottom dot indicator
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboadingContent.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: controller.currentPage.value == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Color(0xFFCC5500)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // bottomnavigation button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCC5500),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 0,
                        ),
                        // when clicked, call the authentication screen
                        onPressed: () => controller.nextPage(),

                        // using obx to update the  what the button is going to display based on where it is
                        child: Obx(
                          () => Text(
                            controller.lastPage ? "Get Started" : "Next",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}
