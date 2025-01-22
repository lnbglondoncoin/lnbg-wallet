// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
// import 'package:lnbg_crypto_wallet_app/Views/ImportWallet/controller/face_scan_controller.dart';
// import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';

// class FaceScanScreen extends StatelessWidget {
//   FaceScanScreen({super.key});
//   final FaceScanController controller = Get.put(FaceScanController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.h),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Image.asset(
//                   "assets/images/fingerPrint.png",
//                   height: 300.h,
//                   width: 300.w,
//                 ),
//                 Positioned(
//                   bottom: 20.h,
//                   child: Obx(() => Text(
//                         controller.isFaceAuthenticated.value ? "100%" : "Scanning...",
//                         style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
//                       )),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.h),
//             Obx(() => Text(
//                   controller.isFaceAuthenticated.value ? "Face verified successfully." : "Verifying your face...",
//                   style: TextStyle(fontSize: 18.sp, color: Colors.grey),
//                 )),
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
//         child: CustomButton(
//           buttonText: "Continue",
//           onPressed: controller.isFaceAuthenticated.value ? () => print("Proceeding...") : controller.authenticate,
//         ),
//       ),
//     );
//   }
// }
