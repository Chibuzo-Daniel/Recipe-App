import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class OnboardingController extends GetxController {
  //page controller to navigate between pages
  final PageController pageController = PageController();

  // tracking the current page on dispaly
  final currentPage = 0.obs;

  //ckeck if user  is on final page
  final int totalPagesCount = 3;

  bool get lastPage => currentPage.value == 2;

  void updatePage(int index) {
    final safeIndex = index.clamp(0, totalPagesCount - 1);

    currentPage.value = safeIndex;
  }

  void nextPage() {
    if (lastPage) {
      Get.offNamed(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
