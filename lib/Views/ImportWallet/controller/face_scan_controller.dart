// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:local_auth/local_auth.dart';
// class FaceScanController extends GetxController {
//   final LocalAuthentication auth = LocalAuthentication();
//   var isFaceAuthenticated = false.obs;

// Future<void> authenticate() async {
//   try {
//     List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
//     print(availableBiometrics);
//     if (availableBiometrics.contains(BiometricType.face)) {
//       print("Face authentication supported");
//       // Get.to(() => FaceScanScreen());
//     } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
//       print("Fingerprint authentication supported");
//       // Get.to(() => FingerprintScanScreen());
//     } 
//     else if(availableBiometrics.contains(BiometricType.face)&&availableBiometrics.contains(BiometricType.fingerprint)){
//     print("Both authentications supported");
//     }
//     else {
//       print("No biometric authentication available");
//     }
//   } on PlatformException catch (e) {
//     print("Error during authentication: $e");
//   }
// }

// }
