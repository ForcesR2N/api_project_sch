import 'package:api_project/component/my_colors.dart';
import 'package:api_project/component/my_textfield.dart';
import 'package:api_project/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyTextfield(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        obscureText: false,
                        prefixIcon: const Icon(Icons.person_2_rounded),
                        onChanged: authController.updateUsername,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      MyTextfield(
                        labelText: 'Password',
                        hintText: 'Enter you password',
                        obscureText: true,
                        prefixIcon: const Icon(Icons.password_outlined),
                        onChanged: authController.updatePassword,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter you password';
                          }
                          if (value.length < 8) {
                            return 'Password minimum 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authController.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Obx(
                          () => authController.isLoading.value
                              ? Lottie.asset(
                                  'lib/assets/animation_mini_loading.json')
                              : Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
