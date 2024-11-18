import 'package:api_project/controllers/api_service.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_register/login_page.dart';
import 'package:api_project/utils/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static const String KEY_IS_LOGGED_IN = 'isLoggedIn';
  static const String KEY_USERNAME = 'username';
  static const String KEY_FULL_NAME = 'fullName';
  static const String KEY_EMAIL = 'email';

  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  var isLoggedIn = false.obs;

  late SharedPreferences _prefs;

   @override
  void onInit() {
    super.onInit();
  }

    Future<void> initializeController() async {
    _prefs = await SharedPreferences.getInstance();
    await loadUserData();
    print("Auth State: ${isLoggedIn.value}"); // Debug print
  }

   Future<void> loadUserData() async {
    try {
      isLoggedIn.value = _prefs.getBool(KEY_IS_LOGGED_IN) ?? false;
      if (isLoggedIn.value) {
        username.value = _prefs.getString(KEY_USERNAME) ?? '';
        fullName.value = _prefs.getString(KEY_FULL_NAME) ?? '';
        email.value = _prefs.getString(KEY_EMAIL) ?? '';
        print("Loaded user data - Username: ${username.value}"); // Debug print
      }
    } catch (e) {
      print("Error loading user data: $e"); // Debug print
      isLoggedIn.value = false;
    }
  }

  Future<void> saveUserData() async {
    try {
      await _prefs.setBool(KEY_IS_LOGGED_IN, true);
      await _prefs.setString(KEY_USERNAME, username.value);
      await _prefs.setString(KEY_FULL_NAME, fullName.value);
      await _prefs.setString(KEY_EMAIL, email.value);
      isLoggedIn.value = true;
      print("Saved user data successfully"); // Debug print
    } catch (e) {
      print("Error saving user data: $e"); // Debug print
    }
  }

  void updateUsername(String value) => username.value = value.trim();
  void updatePassword(String value) => password.value = value.trim();
  void updateFullName(String value) => fullName.value = value.trim();
  void updateEmail(String value) => email.value = value.trim();

  void clearFields() {
    password.value = '';
  }

  Future<void> clearAllFields() async {
    try {
      await _prefs.clear();
      username.value = '';
      password.value = '';
      fullName.value = '';
      email.value = '';
      isLoggedIn.value = false;
      print("Cleared all fields and preferences"); // Debug print
    } catch (e) {
      print("Error clearing data: $e"); // Debug print
    }
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> login() async {
    try {
      if (username.isEmpty || password.isEmpty) {
        SnackbarHelper.showError('Username and password are required!');
        return;
      }

      isLoading.value = true;

      final response = await ApiService.login(
        username.value,
        password.value,
      );

      if (response['status'] == true) {
        if (response['data'] != null) {
          final data = response['data'];
          fullName.value = data['full_name'] ?? '';
          email.value = data['email'] ?? '';
        }

        await saveUserData();
        SnackbarHelper.showSuccess('Login successful!');
        clearFields();
        Get.offAll(
          () => HomePage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        SnackbarHelper.showError(response['message'] ?? 'Login failed');
      }
    } catch (e) {
      SnackbarHelper.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    clearAllFields(); 
    Get.offAll(
      () => const LoginPage(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> register() async {
    try {
      if (!isValidEmail(email.value)) {
        SnackbarHelper.showError('Please enter a valid email address');
        return;
      }

      isLoading.value = true;

      final response = await ApiService.register(
        username: username.value,
        password: password.value,
        fullName: fullName.value,
        email: email.value,
      );

      if (response['status'] == true) {
        SnackbarHelper.showSuccess('Registration success');
        clearAllFields();
        Get.off(
          () => const LoginPage(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        SnackbarHelper.showError(response['message'] ?? 'Registration failed');
      }
    } catch (e) {
      SnackbarHelper.showError('An unexpected error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}