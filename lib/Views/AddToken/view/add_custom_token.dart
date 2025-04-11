import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/search_network.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/patse_textfeild.dart';

class AddCustomToken extends StatelessWidget {
  const AddCustomToken({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final controller = Get.put(AddTokenController());
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(title: "Add Custom Token", iconPath: ""),
      body: LayoutBuilder(builder:(context,constraints){
        return SingleChildScrollView(
        child:ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDarkMode ? lightBlackColor2 : whiteColor,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(
                            color: isDarkMode ? lightBlackColor : lightBlack,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.to(() => SearchNetworkScreen()),
                                child: Row(
                                  children: [
                                    Text(
                                      "Network",
                                      style: GoogleFonts.urbanist(
                                        fontWeight: FontWeight.w700,
                                        color:
                                            isDarkMode ? whiteColor : blackColor2,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                    Obx(() {
                                      return Text(
                                        controller.selectedNetwork.value,
                                        style: GoogleFonts.urbanist(
                                          fontWeight: FontWeight.w700,
                                          color: isDarkMode
                                              ? whiteColor
                                              : blackColor2,
                                          fontSize: 20.sp,
                                        ),
                                      );
                                    }),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      height: 24.h,
                                      width: 24.w,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          "assets/icons/arrowRight.svg",
                                          colorFilter: ColorFilter.mode(
                                            isDarkMode
                                                ? lightGreenColor
                                                : orange3,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.h),
                              const CustomDivider(),
                              SizedBox(height: 15.h),
                              CustomTextFieldWithPaste(
                                controller: controller.addressController,
                                validator: controller.validateAddress,
                                hintText: "Contract Address",
                                isDarkMode: isDarkMode,
                                lightColor: lightWhiteColor,
                                darkColor: lightBlackColor2,
                                accentColor:
                                    isDarkMode ? lightGreenColor : orange4,
                              ),
                              SizedBox(height: 15.h),
            
                              // Name
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? lightBlackColor3
                                      : lightWhiteColor,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: TextFormField(
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Name",
                                    hintStyle: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor2,
                                      fontSize: 18.sp,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                  ),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode ? whiteColor : blackColor2,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
            
                              // Symbol
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? lightBlackColor3
                                      : lightWhiteColor,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: TextFormField(
                                  controller: controller.symbolController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Symbol",
                                    hintStyle: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor2,
                                      fontSize: 18.sp,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                  ),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode ? whiteColor : blackColor2,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h),
            
                              // Decimals
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? lightBlackColor3
                                      : lightWhiteColor,
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: TextFormField(
                                  controller: controller.decimalController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Decimals",
                                    hintStyle: GoogleFonts.urbanist(
                                      fontWeight: FontWeight.w400,
                                      color: greyColor2,
                                      fontSize: 18.sp,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w),
                                  ),
                                  style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.w400,
                                    color: isDarkMode ? whiteColor : blackColor2,
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
            
                      // Info container
                      Container(
                        height: 84.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          color: orange6.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Row(
                            children: [
                              Container(
                                height: 20.h,
                                width: 20.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: orange5,
                                ),
                                child: Center(
                                  child: Text(
                                    "!",
                                    style: GoogleFonts.urbanist(
                                      color: whiteColor,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: Text(
                                  "Anyone can create token, including a fake versions of existing tokens. Learn more about scams and security risks.",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.urbanist(
                                    color: orange5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
            
                      // Expansion
                      Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          iconColor: isDarkMode ? lightGreenColor : orange3,
                          collapsedIconColor:
                              isDarkMode ? lightGreenColor : orange3,
                          tilePadding: EdgeInsets.zero,
                          title: Text(
                            "What is Custom Token?",
                            style: GoogleFonts.urbanist(
                              color: isDarkMode ? lightGreenColor : orange3,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          childrenPadding: EdgeInsets.only(top: 10.h),
                          children: [
                            Text(
                              "A custom token in MetaMask refers to a token that is not automatically detected and needs to be manually added. "
                              "This is common for lesser-known, new, or personally created tokens.\n\n"
                              "You typically need the following to add a custom token:\n"
                              "• Token Contract Address\n"
                              "• Token Symbol (e.g., LNB)\n"
                              "• Decimals (usually 18)\n\n"
                              "Use trusted sources like Etherscan or the project's official website to get accurate token details.\n\n"
                              "⚠️ Anyone can create fake tokens, so always double-check before importing!",
                              style: GoogleFonts.urbanist(
                                fontSize: 14.sp,
                                color: isDarkMode ? whiteColor : blackColor2,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const CustomDivider(),
                SizedBox(height: 220.h),
              ],
            ),
          ),
        ),
      );
      }),
      
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomButton(
          buttonText: "Ok",
          onPressed: () {
            // TODO: Hook up submit logic
          },
        ),
      ),
    );
  }
}
