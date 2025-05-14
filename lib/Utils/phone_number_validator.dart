import 'package:get/get.dart';

class PhoneNumberValidator {
  static bool isValid(String phoneNumber) {
    // Basic validation: Check if the phone number contains only digits and has a valid length
    final regex = RegExp(r'^\+?[1-9]\d{1,14}\$'); // E.164 format
    if (!regex.hasMatch(phoneNumber)) {
      Get.snackbar(
        "Invalid Phone Number",
        "The phone number provided is not valid. Please check and try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }
}
