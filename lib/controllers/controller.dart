import 'package:get/get.dart';

class Controller extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  void changedUsername(String value) {
    username.value = value.trim();
  }

    void changedPassword(String value) {
    password.value = value.trim();
  }
}
