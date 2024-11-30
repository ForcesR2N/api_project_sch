import 'package:api_project/component/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const MyTextfield(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.obscureText,
      required this.prefixIcon,
      this.onChanged,
      this.validator, this.controller});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: const TextStyle(color: AppColor.primaryBlue),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColor.primaryBlue,
              width: 1.5,
            ),
          ),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
