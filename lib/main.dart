import 'package:api_project/controllers/auth_controller.dart';
import 'package:api_project/controllers/bottom_navbar_controller.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BottomnavbarController());
  final authController = Get.put(AuthController());
  await authController.initializeController();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
     final authController = Get.find<AuthController>();
    return GetMaterialApp(
      title: 'Flutter GetX API Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: Obx(() => authController.isLoggedIn.value ? HomePage() : const LoginPage()),
    );
  }
}
