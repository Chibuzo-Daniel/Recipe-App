import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'routes/app_pages.dart';
import 'bindings/splash_binding.dart';
import 'storage/service_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => ServiceStorage().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe List',
      debugShowCheckedModeBanner: false,
      // inital route is the splash screen
      initialRoute: AppPages.initial,
      // activates the splash controller
      initialBinding: SplashBinding(),
      // defines the routes available in the app
      getPages: AppPages.routes,

      theme: ThemeData(scaffoldBackgroundColor: Colors.white),

      // Set the start screen to the Splash Screen
    );
  }
}
