  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
  import 'package:lnbg_crypto_wallet_app/Views/Wallets/controller/wallet_controller.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class WalletScreen extends StatelessWidget {
   WalletScreen({super.key});
  final controller = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: "Wallets", iconPath: "assets/icons/plusIcon.svg", isSuffix: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.walletIcons.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(controller.walletIcons[index], width: 48.w, height: 48.h),
                    title: Text(controller.walletTitles[index],
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700, fontSize: 20.sp, color: blackColor2)),
                    subtitle: Text(controller.walletSubTitles[index],
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w800, fontSize: 14.sp, color: greyColor3)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset("assets/icons/tick.svg",
                              colorFilter: ColorFilter.mode(index==controller.selectedWallwt.value?lightGreenColor:whiteColor, BlendMode.srcIn),),
                              
                          
                          
                          SizedBox(width: 10.w,),
                        PopupMenuButton<String>(
                          color: whiteColor,
                          onSelected: (value) {
                             controller.changeSelectedWallet(index);
                            if (value == 'Edit') {
                             // controller.changeSelectedWallet(index);
                              // Add edit functionality here
                            } else if (value == 'Delete') {
                              controller.deleteWallet(index);
                            }
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/threeDots.svg",
                            colorFilter: ColorFilter.mode(blackColor2, BlendMode.srcIn),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              
                            
                              value: 'Edit',
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/Edit.svg",
                                      colorFilter: ColorFilter.mode(blackColor2, BlendMode.srcIn),),
                                      SizedBox(width: 20.w,),
                                      Text('Edit',
                                          style: GoogleFonts.urbanist(
                                            color: blackColor2,
                                              fontWeight: FontWeight.w800, fontSize: 18.sp)),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomDivider()
                                ],
                              ),
                            ),
                                     PopupMenuItem(
                              value: 'Show Secret Phrase',
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Center(
                                          child: SvgPicture.asset("assets/icons/eye.svg",
                                        ),
                                        ),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Text('Show Secret Phrase',
                                          style: GoogleFonts.urbanist(
                                            color: blackColor2,
                                              fontWeight: FontWeight.w800, fontSize: 18.sp)),
                                    ],
                                  ),
                                  SizedBox(height: 10.h,),
                                  CustomDivider()
                                ],
                              ),
                            ),
                       
                            PopupMenuItem(
                              value: 'Delete',
                              child:  Row(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Center(
                                          child: SvgPicture.asset("assets/icons/delete.svg",
                                          colorFilter: ColorFilter.mode(pinkColor, BlendMode.srcIn),),
                                        ),
                                      ),
                                      SizedBox(width: 20.w,),
                                      Text('Delete',
                                          style: GoogleFonts.urbanist(
                                            color: pinkColor,
                                               fontWeight: FontWeight.w800, fontSize: 18.sp)),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: index != controller.walletIcons.length - 1,
                  child: CustomDivider(),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}