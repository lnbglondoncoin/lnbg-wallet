import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Models/coin_model.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/controller/receive_coin_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveCoinQR extends StatelessWidget {
  final TokenData token;

  ReceiveCoinQR({super.key, required this.token});
  final walletCreatingController = Get.find<WalletCreatingController>();
  final controller = Get.put(ReceiveCoinController());
  final GlobalKey _qrKey = GlobalKey(); // Define GlobalKey
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomAppBar(
        title: "Receive ${token.symbol}",
        iconPath: 'assets/icons/search.svg',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            children: [
              Center(
                child: Image.network(
                  token.logoUrl,
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
                  child: RepaintBoundary(
                    key: _qrKey, // Attach GlobalKey here
                    child: QrImageView(
                      padding: EdgeInsets.zero,
                      data: walletCreatingController.wallwtAddress.value,
                      version: QrVersions.auto,
                      foregroundColor: isDarkMode ? Colors.white : Colors.black,
                      backgroundColor: isDarkMode ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SelectableText(
                  textAlign: TextAlign.center,
                  walletCreatingController.wallwtAddress.value,
                  style: GoogleFonts.urbanist(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: isDarkMode ? whiteColor : darkGreyColor),
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
                      color: isDarkMode ? whiteColor : darkGreyColor),
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
                      color: isDarkMode ? whiteColor : darkGreyColor),
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
                        GestureDetector(
                          onTap: () {
                            controller.copyAddress(
                                walletCreatingController.wallwtAddress.value);
                          },
                          child: Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: lightGreenColor.withValues(alpha: 0.08)),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/icons/copy.svg",
                              colorFilter: ColorFilter.mode(
                                  isDarkMode ? lightGreenColor : orange1,
                                  BlendMode.srcIn),
                            )),
                          ),
                        ),
                        Text(
                          "Copy",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color:
                                  isDarkMode ? lightWhiteColor : darkGreyColor),
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
                                color: lightGreenColor.withValues(alpha: 0.08)),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/icons/set.svg",
                              colorFilter: ColorFilter.mode(
                                  isDarkMode ? lightGreenColor : orange1,
                                  BlendMode.srcIn),
                            )),
                          ),
                        ),
                        Text(
                          "Set Amount",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color:
                                  isDarkMode ? lightWhiteColor : darkGreyColor),
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
                                color: lightGreenColor.withValues(alpha: 0.08)),
                            child: Center(
                                child: SvgPicture.asset(
                              "assets/icons/share.svg",
                              colorFilter: ColorFilter.mode(
                                  isDarkMode ? lightGreenColor : orange1,
                                  BlendMode.srcIn),
                            )),
                          ),
                          Text(
                            "Share",
                            style: GoogleFonts.urbanist(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode
                                    ? lightWhiteColor
                                    : darkGreyColor),
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
          iconPath: token.logoUrl,
        );
      },
    );
  }

  Future<File?> _captureQRImage() async {
    try {
      RenderRepaintBoundary? boundary =
          _qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) return null;

      final tempDir = await getTemporaryDirectory();
      final qrFile = File('${tempDir.path}/qr_code.png');

      await qrFile.writeAsBytes(byteData.buffer.asUint8List());

      return qrFile;
    } catch (e) {
      return null;
    }
  }

  void _shareQRCode() async {
    File? imageFile = await _captureQRImage();
    if (imageFile != null) {
      Share.shareXFiles([XFile(imageFile.path)], text: "Here is my QR code!");
    } else {}
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
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
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
            color: isDarkMode ? lightBlackColor2 : whiteColor,
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
                    color: isDarkMode ? lightBlackColor : greyColor,
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
                    color: isDarkMode ? whiteColor : blackColor2,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const CustomDivider(),
              SizedBox(height: 20.h),
              TextFormField(
                controller: controller.amountController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.r),
                    borderSide: BorderSide.none, // Makes the border invisible
                  ),
                  hintText: "Set amount",
                  hintStyle: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w400,
                    color: isDarkMode ? whiteColor : greyColor2,
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
                  fillColor: isDarkMode ? lightBlackColor3 : lightWhiteColor,
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
                          color:
                              isDarkMode ? lightBlackColor : lightGreenColor2,
                          borderRadius: BorderRadius.circular(100.r)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.urbanist(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? lightGreenColor
                                  : lightGreenColor),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    child: isDarkMode
                        ? CustomGreenButton(
                            buttonText: "Confirm",
                            onPressed: () {
                              Navigator.pop(context);
                            })
                        : CustomButton(
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
