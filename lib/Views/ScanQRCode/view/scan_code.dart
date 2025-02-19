import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/controller/qr_scanner_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({super.key});

  @override
  State<ScanQRCodeScreen> createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
  var qrController = Get.put(QrScanproductionController());
  final MobileScannerController _scannerController = MobileScannerController();

  void _handleBarcode(BarcodeCapture barcode) {
    if (barcode.barcodes.isNotEmpty) {
      qrController.scanQr.value = false;
      _scannerController.stop();
      Get.snackbar(
          "QR Code Scanned", barcode.barcodes.first.rawValue ?? "No Data");
    }
  }

  @override
  void initState() {
    qrController.scanQr.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var theme = Theme.of(context);
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: lightBlackColor3,
      appBar: AppBar(
        backgroundColor: lightBlackColor3,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: SizedBox(
            height: 28.h,
            width: 28.w,
            child: Center(child: SvgPicture.asset("assets/icons/leading.svg")),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Text(
              "Scan QR Code",
              style: GoogleFonts.urbanist(
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Please point the camera at the QR Code",
              style: GoogleFonts.urbanist(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 50.h),
            Obx(() => qrController.scanQr.value
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 380.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: MobileScanner(
                                  controller: _scannerController,
                                  onDetect: _handleBarcode,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Image.asset(
                               isDarkMode? "assets/images/scanImage2.png": "assets/images/scanImage.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: SizedBox(
                                // height: 380.h,
                                child: AnimatedBuilder(
                                  animation: qrController.animationController,
                                  builder: (context, child) {
                                    double linePosition =
                                        qrController.animation.value * 340.h;
                                    return Stack(
                                      children: [
                                        // Orange section above the moving line
                                        Positioned(
                                          top: 0.h,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.r),
                                                topRight:
                                                    Radius.circular(40.r)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40.r),
                                                    topRight:
                                                        Radius.circular(40.r)),
                                                color:isDarkMode?lightGreenColor.withOpacity(0.3): orange2.withOpacity(
                                                    0.3), // Adjust opacity as needed
                                              ),
                                              height: linePosition,
                                            ),
                                          ),
                                        ),
                                        // Moving scanning line
                                        Positioned(
                                          top: linePosition,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 4.h,
                                            color:
                                                qrController.isMovingDown.value
                                                    ?isDarkMode?lightGreenColor: orange2
                                                    : Colors.white,
                                          ),
                                        ),
                                        // Transparent section below the moving line
                                        Positioned(
                                          top: linePosition + 4.h,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(
                    height: 380.h,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(  isDarkMode? "assets/images/scanImage2.png": "assets/images/scanImage.png",),
                            fit: BoxFit.fill)),
                  )),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconButton(isDarkMode?"assets/icons/gallery2.svg":"assets/icons/gallery.svg"),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                  onTap: () {
                    qrController.startScanning();
                  },
                  child: Container(
                    height: 100.h,
                    width: 100.w,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [isDarkMode?lightGreenColor: orange2,isDarkMode?greenColor2: orange1]),
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/icons/scanner.svg"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                _buildIconButton(isDarkMode?"assets/icons/file2.svg":"assets/icons/file.svg"),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(String asset) {
    return Container(
      height: 58.h,
      width: 58.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: lightGreenColor.withOpacity(0.08),
      ),
      child: Center(
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
