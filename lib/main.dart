import 'package:api_project/controllers/auth_controller.dart';
import 'package:api_project/controllers/bottom_navbar_controller.dart';
import 'package:api_project/controllers/team_controller.dart';
import 'package:api_project/pages/home.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_register/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  Get.put(BottomnavbarController());
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX API Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
