import 'package:api_project/component/my_colors.dart';
import 'package:api_project/component/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: Column(children: [
            SizedBox(height: 100),
            MyTextfield(
                labelText: 'Username',
                hintText: 'Enter you username',
                obscureText: false),
          ])),
    );
  }
}
