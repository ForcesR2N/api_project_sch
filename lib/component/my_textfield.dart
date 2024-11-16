import 'package:api_project/component/my_colors.dart';
import 'package:api_project/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  MyTextfield({super.key, required this.labelText, required this.hintText, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());

    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Enter your username',
          labelStyle: TextStyle(color: AppColor.primaryBlue),
          prefixIcon: Icon(Icons.person_2_rounded),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: AppColor.primaryBlue,
              width: 1.5,
            ),
          ),
        ),
        obscureText: false,
        onChanged: (value) {
          controller.changedName(value);
        },
      ),
    );
  }
}
