import 'package:api_project/controllers/api_service.dart';
import 'package:api_project/pages/home_page.dart';
import 'package:api_project/pages/login_register/login_page.dart';
import 'package:api_project/utils/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var username = ''.obs;
  var password = ''.obs;
  var fullName = ''.obs;
  var email = ''.obs;
  
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (box.read('isLoggedIn') == true) {
      username.value = box.read('username') ?? '';
      fullName.value = box.read('fullName') ?? '';
      email.value = box.read('email') ?? '';
      Get.offAll(() => HomePage());
    }
  }

  void saveUserData() {
    box.write('isLoggedIn', true);
    box.write('username', username.value);
    box.write('fullName', fullName.value);
    box.write('email', email.value);
  }

  void updateUsername(String value) => username.value = value.trim();
  void updatePassword(String value) => password.value = value.trim();
  void updateFullName(String value) => fullName.value = value.trim();
  void updateEmail(String value) => email.value = value.trim();

  void clearFields() {
    password.value = '';
  }

  void clearAllFields() {
    username.value = '';
    password.value = '';
    fullName.value = '';
    email.value = '';
    // Clear storage saat logout
    box.erase();
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
        
        saveUserData(); // Simpan data user setelah login berhasil
        SnackbarHelper.showSuccess('Login successful!');
        clearFields();
        Get.offAll( // Gunakan offAll agar tidak bisa kembali ke login page
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
    clearAllFields(); // Ini akan menghapus data di storage juga
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