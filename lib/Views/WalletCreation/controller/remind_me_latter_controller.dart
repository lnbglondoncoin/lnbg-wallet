import 'package:get/get.dart';

class RemindMeLatterController extends GetxController{
   var isChecked = false.obs;

  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
}