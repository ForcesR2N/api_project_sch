import 'package:api_project/controllers/auth_controller.dart';
import 'package:api_project/controllers/bottom_navbar_controller.dart';
import 'package:api_project/controllers/firebase_api.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_register/login_page.dart';
import 'package:api_project/pages/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(BottomnavbarController());
  final authController = Get.put(AuthController());
  await authController.initializeController();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return GetMaterialApp(
        title: 'Flutter GetX API Example',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),home: HomePage(),
        // home: Obx(() =>
        //     authController.isLoggedIn.value ? HomePage() : const LoginPage()),
        navigatorKey: navigatorKey,
        routes: {
          '/notification_page': (context) => const NotificationPage(),
        });
  }
}
