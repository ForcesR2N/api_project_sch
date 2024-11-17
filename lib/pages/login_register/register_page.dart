import 'package:api_project/component/my_colors.dart';
import 'package:api_project/component/my_textfield.dart';
import 'package:api_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextfield(
                  labelText: 'Username',
                  hintText: 'Enter you username',
                  obscureText: true,
                  prefixIcon: Icon(Icons.person_2_outlined),
                  onChanged: (value) {
                    authController.username.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your username';
                    }
                  },
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      )),
    );
  }
}
