import 'package:get/get.dart';

class TokenDetailsController extends GetxController{
   // Define two RxBool variables for the switches
  RxBool isSwitched1 = false.obs;
  RxBool isSwitched2 = true.obs;

  // Method to toggle the first switch
  void toggleSwitch1() {
    isSwitched1.value = !isSwitched1.value;
  }
}