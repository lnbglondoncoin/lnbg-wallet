import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/controller/receive_coin_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveCoinQR extends StatelessWidget {
  final String coinIconPath;
  final String coinCode;
  final String coinFullName;

  const ReceiveCoinQR({
    super.key,
    required this.coinIconPath,
    required this.coinCode,
    required this.coinFullName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        title: "Receive $coinCode",
        iconPath: 'assets/icons/search.svg',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  coinIconPath,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              SizedBox(height: 10.h),
              const CustomDivider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 360.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: QrImageView(
                    padding: EdgeInsets.zero,
                    data: "https://your-wallet-address-or-info.com/$coinCode",
                    version: QrVersions.auto,
                    // size: 380.h,
                    backgroundColor: whiteColor,
                    errorStateBuilder: (context, error) {
                      return Center(
                        child: Text(
                          "Oops! Something went wrong.",
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  textAlign: TextAlign.center,
                  "0x7131CA84856767fjfh8sjhqak8s88848f8E696",
                  style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: darkGreyColor),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const CustomDivider(),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  textAlign: TextAlign.center,
                  "Send only Ethereum (ETH) to this address.",
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  textAlign: TextAlign.center,
                  "Sending any other coins may result in permanent loss.",
                  style: GoogleFonts.urbanist(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: lightGreenColor.withOpacity(0.08)),
                          child: Center(
                              child: SvgPicture.asset("assets/icons/copy.svg")),
                        ),
                        Text(
                          "Copy",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: darkGreyColor),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showCustomBottomSheet(context);
                          },
                          child: Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGreenColor.withOpacity(0.08)),
                            child: Center(
                                child:
                                    SvgPicture.asset("assets/icons/set.svg")),
                          ),
                        ),
                        Text(
                          "Set Amount",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: darkGreyColor),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _shareQRCode();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGreenColor.withOpacity(0.08)),
                            child: Center(
                                child:
                                    SvgPicture.asset("assets/icons/share.svg")),
                          ),
                          Text(
                            "Share",
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: darkGreyColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen height
      backgroundColor: Colors.transparent, // Transparent background
      builder: (context) {
        return AnimatedBottomSheet(
          iconPath: coinIconPath,
        );
      },
    );
  }

  void _shareQRCode() async {
    try {
      final qrImage = await _captureQRImage();
      if (qrImage != null) {
        await Share.shareXFiles([XFile(qrImage.path)],
            text: 'Scan this QR code!');
      }
    } catch (e) {
    //  print("Error sharing QR code: $e");
    }
  }

  Future<File?> _captureQRImage() async {
    try {
      final qrPainter = QrPainter(
        data: "https://your-wallet-address-or-info.com/$coinCode",
        version: QrVersions.auto,
        gapless: false,
      );

      // Get the temporary directory to save the QR image
      final tempDir = await getTemporaryDirectory();
      final qrFile = File('${tempDir.path}/qr_code.png');

      // Convert the QR code into image data
      final image = await qrPainter.toImageData(300);

      // Write the image data to the file
      await qrFile.writeAsBytes(image!.buffer.asUint8List());

      return qrFile;
    } catch (e) {
    //  print("Error capturing QR image: $e");
      return null;
    }
  }
}

class AnimatedBottomSheet extends StatefulWidget {
  final String iconPath;

  const AnimatedBottomSheet({super.key, required this.iconPath});
  @override
  AnimatedBottomSheetState createState() => AnimatedBottomSheetState();
}

class AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  final controller = Get.put(ReceiveCoinController());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start position (bottom of screen)
      end: const Offset(0, 0), // End position (fully visible)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.reverse(); // Animate closing before disposal
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
            left: 25.w,
            right: 25.w,
            top: 10.h,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(49.r),
              topRight: Radius.circular(49.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38.w,
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "Set Amount",
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.sp,
                    color: blackColor2,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const CustomDivider(),
              SizedBox(height: 20.h),
              TextFormField(
                controller: controller.ammountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide.none, // Makes the border invisible
                  ),
                  hintText: "Set amount",
                  hintStyle: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w400,
                    color: greyColor2,
                    fontSize: 18.sp,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Center(
                        child: Image.asset(
                          widget.iconPath,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                  ),
                  fillColor: lightWhiteColor,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                enableInteractiveSelection: false,
              ),
              SizedBox(height: 20.h),
              const CustomDivider(),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Flexible(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 59.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: lightGreenColor2,
                          borderRadius: BorderRadius.circular(100.r)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: lightGreenColor),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: CustomButton(
                        buttonText: "Confirm",
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
