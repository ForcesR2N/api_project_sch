import 'package:get/get.dart';

class Controller extends GetxController {
  var name = ''.obs;

  void changedName(String newName) {
    name.value = newName;
  }
}
