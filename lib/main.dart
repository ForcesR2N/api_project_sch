import 'package:api_project/controllers/bottom_navbar_controller.dart';
import 'package:api_project/controllers/team_controller.dart';
import 'package:api_project/pages/home.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Get.put(BottomnavbarController());
  runApp(MyApp());
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
