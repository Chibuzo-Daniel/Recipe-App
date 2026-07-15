import 'package:get/get.dart';
import 'package:my_first_app/bindings/onboarding_binding.dart';
import 'package:my_first_app/bindings/splash_binding.dart';

import 'package:my_first_app/views/onboarding_view.dart';
import 'package:my_first_app/views/splash_screen.dart';
import 'package:my_first_app/bindings/auth_binding.dart';
import 'package:my_first_app/views/authentication/register_view.dart';
import 'package:my_first_app/views/authentication/login_view.dart';
import 'package:my_first_app/views/home_view.dart';
import 'package:my_first_app/bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  // define the  first screen to start with
  static const initial = AppRoutes.splash;

  //list of other pages in the app
  static final routes = [
    //splash view
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    // onboarding view
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),

    // Login view
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
    ),

    //Register view
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    // Home view
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
