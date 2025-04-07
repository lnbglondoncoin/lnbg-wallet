import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/controller/add_token_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class SearchNetworkScreen extends StatelessWidget {
   SearchNetworkScreen({super.key});
  final walletCreatingController = Get.find<WalletCreatingController>();
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    final controller = Get.put(AddTokenController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
            appBar: CustomAppBar(
        isSuffix: true,
        title: "Select Network",
        iconPath: 'assets/icons/search.svg',
        onSuffixTap: () {
          // Show search dialog on icon tap
          Get.dialog(
            AlertDialog(
              backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
              title: Text(
                "Search Token",
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? whiteColor : blackColor2,
                ),
              ),
              content: TextField(
                controller: searchController,
                onChanged: (value) => searchQuery.value = value.toLowerCase(),
                style: TextStyle(color: isDarkMode ? whiteColor : blackColor2),
                decoration: InputDecoration(
                  hintText: "Enter token name...",
                  hintStyle: TextStyle(color: greyColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Close",
                    style: TextStyle(color: isDarkMode ? whiteColor : blackColor2),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      body: SizedBox(
        height: Get.height,
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: Obx(() {
                var filteredTokens = walletCreatingController.hundredTokenData
            .where((token) =>
                token.name.toLowerCase().contains(searchQuery.value))
            .toList();
              return controller.isLoading.value
                  ? Center(
                      child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [orange1, orange2], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: SpinKitCircle(
                        color: Colors.white, // Set a neutral color for blending
                        size: 50.h,
                      ),
                    ))
                  : filteredTokens.isEmpty
                      ? Center(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      //  controller.filterTokens(query);
                                    },
                                    child: Image.asset(
                                      "assets/images/searchImage.png",
                                      height: 300.h,
                                      width: 300.w,
                                    )),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Not Found",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: blackColor2),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor2),
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                           itemCount: filteredTokens.length,
                          itemBuilder: (context, index) {
                             final token = filteredTokens[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      index ==filteredTokens.length - 1
                                          ? 80.h
                                          : 0.h),
                              child: GestureDetector(
                                onTap: () {
                                  controller.changeNetwork(
                                      token);
                                  Get.back();
                                },
                                child: Container(
                                  height: 70.h,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: lightBlack))),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 45.h,
                                          width: 35.w,
                                          child: Center(
                                            child: Image.network(
                                              token.logoUrl,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Text(
                                          token.name,
                                          style: GoogleFonts.urbanist(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isDarkMode
                                                  ? whiteColor
                                                  : blackColor2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
            })),
      ),
    );
  }
}
