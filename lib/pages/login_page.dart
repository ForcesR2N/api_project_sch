import 'package:api_project/component/my_colors.dart';
import 'package:api_project/component/my_textfield.dart';
import 'package:api_project/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextfield(
                labelText: 'Username',
                hintText: 'Enter your username',
                obscureText: false,
                prefixIcon: const Icon(Icons.person_2_rounded),
                onChanged: (value) {
                  controller.changedUsername(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your username';
                  }
                  return null;
                },
              ),
              MyTextfield(
                labelText: 'Password',
                hintText: 'Enter you password',
                obscureText: true,
                prefixIcon: const Icon(Icons.password_outlined),
                onChanged: (value) {
                  controller.changedPassword(value);
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter you password';
                  }
                  if (value.length > 8) {
                    return 'Password is minimum 8';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
