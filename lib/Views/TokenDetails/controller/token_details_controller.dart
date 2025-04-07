import 'package:get/get.dart';

class TokenDetailsController extends GetxController{
  RxBool isSwitched1 = false.obs;
  RxBool isSwitched2 = true.obs;
  void toggleSwitch1() {
    isSwitched1.value = !isSwitched1.value;
  }
}