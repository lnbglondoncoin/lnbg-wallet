import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/controller/swap_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/hundred_tokens_shimmer_loader.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/reusable_search_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';

class SelectCoinToSwap extends StatelessWidget {
  final bool firstCoin;
  SelectCoinToSwap({super.key, required this.firstCoin});
  final controller = Get.put(SwapController());
  final walletCreatingController = Get.find<WalletCreatingController>();
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
   final RxBool showSearchBar = false.obs;
  @override
  Widget build(BuildContext context) {
    
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        appBar:  PreferredSize(
             preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Obx((){
            return 
            walletCreatingController.isLoading.value
        ? ShimmerAppBar(isDarkMode: isDarkMode):
            CustomAppBar(
            isSuffix: true,
            title: "Select Coin",
            iconPath: 'assets/icons/search.svg',
                    onSuffixTap: () {
            // Show a search bar when the icon is tapped
      showSearchBar.value = !showSearchBar.value; // Toggle search bar visibility
                    if (!showSearchBar.value) {
                      searchQuery.value = ""; // Clear search query when hiding search bar
                    }
       },
      
          );
          }),
        ),
        body: Obx(() {
            // var filteredTokens = walletCreatingController.hundredTokenData
            // .where((token) =>
            //     token.name.toLowerCase().contains(searchQuery.value))
            // .toList();
       
        var filteredTokens = walletCreatingController.hundredTokenData
    .where((token) =>
        token.contractAddress.toLowerCase() !=
            "0xdb6675d9740f6401dcd0bb3092fa4dc88c2a0f66" &&
        token.name.toLowerCase().contains(searchQuery.value))
    .toList();
 return 
        Column(
             children: [
                    if (showSearchBar.value)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                child:
                
                ReusableSearchBar(controller: searchController,
                  onChanged: (value) => searchQuery.value = value.toLowerCase(),
                  isDarkMode: isDarkMode,),
          
              ),
               Expanded(
                child: 
                    walletCreatingController.isLoading.value
                  ? TokenListShimmerWidget(isDarkMode: isDarkMode)
                  : filteredTokens.isEmpty
                      ? Center(
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
                        )
                      :
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: ListView.builder(
                      itemCount:filteredTokens.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final token = filteredTokens[index];
               
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index ==
                                     filteredTokens.length - 1
                                  ? 50.h
                                  : 0),
                          child: GestureDetector(
                            onTap: () {
                              if (firstCoin == true) {
                                controller.updateFirstToken(token);
                              } else {
                                controller.updateSecondToken(token);
                              }
                            },
                            child: Container(
                              // height: 80.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: isDarkMode
                                              ? lightBlackColor
                                              : lightBlack))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                      width: 15.w,
                                    ),
                                    SizedBox(
                                      width: Get.width/3,
                                      child: Text(
                                        maxLines: 3,
                                        token.name,
                                        style: GoogleFonts.urbanist(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: isDarkMode
                                                ? whiteColor
                                                : blackColor2),
                                      ),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "\$${token.balance.toStringAsFixed(2)} ${token.symbol}",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isDarkMode
                                                  ? whiteColor
                                                  : blackColor2),
                                        ),
                                        Text(
                                          "\$${token.balanceInUsd.toStringAsFixed(2)}",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
                                              color: isDarkMode
                                                  ? greyColor
                                                  : greyColor3),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                         ),
             ],
           );
        }));
  }
}
