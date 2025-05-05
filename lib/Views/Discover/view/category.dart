import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/controller/descover_controlelr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/coin_properties.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/token_details.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:shimmer/shimmer.dart';

class CoinsCategoryScreen extends StatefulWidget {
  final String category;
  const CoinsCategoryScreen(
      {super.key, required this.category,});

  @override
  State<CoinsCategoryScreen> createState() => _CoinsCategoryScreenState();
}

class _CoinsCategoryScreenState extends State<CoinsCategoryScreen> {
  final DiscoverController controller = Get.put(DiscoverController());
  final walletCreatingController = Get.find<WalletCreatingController>();
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.fetchAllTokensOfCategory(widget.category,walletCreatingController.wallwtAddress.value);
  });
}
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: CustomAppBar(
        title: widget.category,
        iconPath: "assets/icons/search.svg",
        isSuffix: true,
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
      body: Obx((){
          var filteredTokens =  controller.tokenList
            .where((token) =>
                token.name.toLowerCase().contains(searchQuery.value))
            .toList();
        return controller.isLoading.value?coinSkeletonLoader(isDarkMode, widget.category == "Staking"):
          filteredTokens.isEmpty?Center(
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off,
                    size: 60.sp,
                    color: isDarkMode ? greyColor : Colors.grey),
                SizedBox(height: 12.h),
                Text(
                  "No results found",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? greyColor : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ):
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredTokens.length,
            itemBuilder: (context, index) {
              var crypto = filteredTokens[index];
              //  var cryptos = controller.cryptoList[indexx];
              //  var crypto=cryptos[index];
              return 
              
            
              Padding(
                padding:  EdgeInsets.only(bottom: index==filteredTokens.length-1?50.h:0.h),
                child: GestureDetector(
                  onTap: () {
                      Get.toNamed(AppRoutes.tokenDetailsScreen,arguments: crypto);
                    //  Get.to(() =>
                    //                                               TokenDetailsScreen(
                    //                                                 token:
                    //                                                     crypto,
                    //                                               ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color:
                                    isDarkMode ? lightBlackColor : greyColor))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(crypto.logoUrl),
                          ),
                          title: widget.category == 'Staking'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${crypto.name} (${crypto.symbol})",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            isDarkMode ? whiteColor : blackColor2,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "APR:",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w800,
                                              color: isDarkMode
                                                  ? greyColor
                                                  : greyColor3),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          "${crypto.trendPercentage}%",
                                          style: GoogleFonts.urbanist(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                crypto.trendPercentage.toString().startsWith('-')
                                                    ?  pinkColor
                                                    : skyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  "${crypto.name} (${crypto.symbol})",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: isDarkMode ? whiteColor : blackColor2,
                                  ),
                                ),
                          trailing: Visibility(
                            visible: widget.category != 'Staking',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "\$${crypto.priceInUsd.toStringAsFixed(2)}",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color:
                                          isDarkMode ? whiteColor : blackColor2),
                                ),
                                Text(
                                  "${crypto.trendPercentage}%",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: crypto.trendPercentage.toString().startsWith('-')
                                        ? pinkColor
                                        :  skyColor,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              );
            }),
      );
      })   );
  }


Widget coinSkeletonLoader(bool isDarkMode, bool isStaking) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    itemCount: 20, // Number of shimmer items
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(bottom: index == 19 ? 50.h : 0.h),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDarkMode ? lightBlackColor : greyColor,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Shimmer.fromColors(
            baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading Avatar
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 12.w),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: isStaking
                        ? [
                            Container(
                              height: 16.h,
                              width: 120.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 30.w,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5.w),
                                Container(
                                  height: 12.h,
                                  width: 50.w,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ]
                        : [
                            Container(
                              height: 16.h,
                              width: 140.w,
                              color: Colors.grey,
                            ),
                          ],
                  ),
                ),

                // Trailing Price
                if (!isStaking)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 14.h,
                        width: 60.w,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        height: 12.h,
                        width: 40.w,
                        color: Colors.grey,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}
