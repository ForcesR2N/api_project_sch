import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;

  void clearFields() {
    username.value = '';
    password.value = '';
    fullName.value = '';
    email.value = '';
  }

  void updateUsername(String value) => username.value = value.trim();
  void updatePassword(String value) => password.value = value.trim();
  void updateFullName(String value) => fullName.value = value.trim();
  void updateEmail(String value) => email.value = value.trim();

  Future<void> register() async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('https://mediadwi.com/api/latihan/register-user'),
        body: {
          'username': username,
          'password': password,
          'full_name': fullName,
          'email': email,
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Registration successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearFields();
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          data['message'] ?? 'Registration failed',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await http.post(
          Uri.parse('https://mediadwi.com/api/latihan/login'),
          body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Login Success');
        clearFields();
      } else {
        Get.snackbar('Failed', 'Login Failed');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
