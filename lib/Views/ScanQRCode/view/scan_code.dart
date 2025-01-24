import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/controller/qr_scanner_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_edge_container.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRCodeScreen extends StatefulWidget {
  const ScanQRCodeScreen({super.key});

  @override
  State<ScanQRCodeScreen> createState() => _ScanQRCodeScreenState();
}

class _ScanQRCodeScreenState extends State<ScanQRCodeScreen> {
    var qrController = Get.put(QrScanproductionController());

  void _handelBarcode(BarcodeCapture barcode) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    qrController.scanQr.value = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor2,
      appBar: AppBar(
        //automaticallyImplyLeading: true,
        backgroundColor: blackColor2,
        automaticallyImplyLeading: true,
        leading: SizedBox(
          height: 28.h,
          width:28.w,
          child: Center(child: SvgPicture.asset("assets/icons/leading.svg")))
      ),
      body: Column(
        children: [
          Text("Scan QR Code",style: GoogleFonts.urbanist(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
            color: whiteColor
          ),),
          SizedBox(height: 30.h,),
          Text("Please point the camera at the QR Code",style: GoogleFonts.urbanist(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: whiteColor
          ),),
              SizedBox(height: 50.h,),
          Center(child: Obx(() {
                return qrController.scanQr.value
                    ? CustomEdgeContainer(

                        // color: Colors.yellow,
                        child: MobileScanner(
                        onDetect: _handelBarcode,
                      ))
                    : const CustomEdgeContainer(

                        // color: Colors.yellow,
                        child: SizedBox());
              })),
        ],
      ),
    );
  }
}