import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/add_custom_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_switch.dart';

class AddTokenScreen extends StatelessWidget {
  AddTokenScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final walletCreatingController = Get.find<WalletCreatingController>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;
    final controller = Get.put(AddTokenController());

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        shadowColor: isDarkMode ? lightBlackColor3 : whiteColor,
        foregroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        surfaceTintColor: isDarkMode ? lightBlackColor3 : whiteColor,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SizedBox(
            height: 28.h,
            width: 28.w,
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/leading.svg",
                colorFilter: ColorFilter.mode(
                  isDarkMode ? whiteColor : blackColor2,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        title: Obx(() {
          return Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: controller.isAmountEmpty.value
                  ? isDarkMode
                      ? lightBlackColor2
                      : lightWhiteColor
                  : lightGreenColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: controller.isAmountEmpty.value
                    ? isDarkMode
                        ? lightBlackColor2
                        : lightWhiteColor
                    : isDarkMode
                        ? lightGreenColor
                        : orange3,
              ),
            ),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) => searchQuery.value = value.trim().toLowerCase(),
              decoration: InputDecoration(
                prefixIcon: SizedBox(
                  height: 16.h,
                  width: 16.w,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/search2.svg",
                      colorFilter: ColorFilter.mode(
                        controller.isAmountEmpty.value
                            ? grey2
                            : isDarkMode
                                ? lightGreenColor
                                : orange3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                border: InputBorder.none,
                hintText: "Search Tokens",
                hintStyle: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w400,
                  color: greyColor2,
                  fontSize: 18.sp,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              ),
            ),
          );
        }),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () => Get.to(() => const AddCustomToken()),
              child: SvgPicture.asset(
                "assets/icons/plusIcon.svg",
                colorFilter: ColorFilter.mode(
                  isDarkMode ? whiteColor : blackColor2,
                  BlendMode.srcIn,
                ),
              ),
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: Container(
        height: Get.height,
        width: double.infinity,
        color: isDarkMode ? lightBlackColor3 : whiteColor,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Obx(() {
            var filteredTokens = walletCreatingController.hundredTokenData
                .where((token) =>
                    token.name.toLowerCase().contains(searchQuery.value))
                .toList();

            if (controller.isLoading.value) {
              return Center(
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        isDarkMode ? greenColor2 : orange1,
                        isDarkMode ? lightGreenColor : orange2
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: SpinKitCircle(
                    color: Colors.white,
                    size: 50.h,
                  ),
                ),
              );
            }

            if (filteredTokens.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        isDarkMode
                            ? "assets/images/searchImage2.png"
                            : "assets/images/searchImage.png",
                        height: 300.h,
                        width: 300.w,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Not Found",
                        style: GoogleFonts.urbanist(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: isDarkMode ? whiteColor : blackColor2,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? whiteColor : blackColor2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredTokens.length,
              itemBuilder: (context, index) {
                final token = filteredTokens[index];
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index == filteredTokens.length - 1 ? 80.h : 0.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: index != 0
                              ? Colors.transparent
                              : isDarkMode
                                  ? lightBlackColor
                                  : whiteColor,
                        ),
                        bottom: BorderSide(
                          color: isDarkMode ? lightBlackColor : whiteColor,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 45.h,
                            width: 35.w,
                            child: Center(
                              child: Image.network(token.logoUrl),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          SizedBox(
                            width: Get.width / 3,
                            child: Text(
                              maxLines: 3,
                              token.name,
                              style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? whiteColor : blackColor2,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Obx(() => CustomSwitch(
                                isSwitched: controller.switchStates[index],
                                onChanged: () => controller.selectedTokenNames
                                    .add(token.name),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        var filteredTokens = walletCreatingController.hundredTokenData
            .where((token) =>
                token.name.toLowerCase().contains(searchQuery.value))
            .toList();

        return Visibility(
          visible: filteredTokens.isNotEmpty &&controller.isAnySwitchOn.value&&
              controller.isLoading.value == false,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: CustomButton(
              buttonText: "Ok",
              onPressed: () async {
                await controller.savePreferences();
              },
            ),
          ),
        );
      }),
    );
  }
}
