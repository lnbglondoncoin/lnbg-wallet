import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/AddToken/view/add_token.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/controller/nft_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/view/import_nft.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/view/nft_gridview.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/view/notification_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/view/scan_code.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Swap/view/swap_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/TokenDetails/view/token_details.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final nftController = Get.put(NftController());
  final walletCreatingController = Get.find<WalletCreatingController>();
    
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Listen for tab changes
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        // If the NFT tab is selected, fetch the NFTs
        nftController.fetchNFTs(walletCreatingController.wallwtAddress.value);
      }
    });
      if(walletCreatingController.hundredTokenData.isEmpty||walletCreatingController.hundredslugs.isEmpty){
        Get.log("Fetching slugs");
      walletCreatingController.fetchSlugs();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // Make status bar transparent
        statusBarIconBrightness:
            Brightness.light, // Adjust icons for visibility
      ),
      child: Scaffold(
          backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
          body: Obx(() {
            return walletCreatingController.isLoading.value
                ? _buildShimmerLayout(isDarkMode)
                : Column(
                    children: [
                      // Image covering only the top area (including the status bar)
                      Container(
                        width: double.infinity,
                        height: Get.height / 2.5.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              isDarkMode
                                  ? "assets/images/home2.png"
                                  : topYellow,
                            ),
                            fit: BoxFit.cover, // Cover only the given height
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 50.h, left: 25.w, right: 25.w, bottom: 30.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // SizedBox(
                                  //   height: 28.h,
                                  //   width: 28.w,
                                  //   child: Center(
                                  //     child: SvgPicture.asset(
                                  //       eyeShowIcon,
                                  //       colorFilter: const ColorFilter.mode(
                                  //           whiteColor, BlendMode.srcIn),
                                  //     ),
                                  //   ),
                                  // ),
                                  // const Spacer(),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Get.to(() => const ScanQRCodeScreen());
                                  //   },
                                  //   child: SizedBox(
                                  //       height: 28.h,
                                  //       width: 28.w,
                                  //       child: Center(
                                  //           child: SvgPicture.asset(scanIcon,
                                  //               colorFilter:
                                  //                   const ColorFilter.mode(
                                  //                       whiteColor,
                                  //                       BlendMode.srcIn)))),
                                  // ),
                                  SizedBox(
                                    width: 15.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => NotificationScreen());
                                    },
                                    child: SizedBox(
                                        height: 28.h,
                                        width: 28.w,
                                        child: Center(
                                            child: SvgPicture.asset(
                                                notification,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        whiteColor,
                                                        BlendMode.srcIn)))),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 30.h,),
                              Center(
                                  child: Text(
                                "\$${walletCreatingController.tBlnc.value.toString()}",
                                // walletCreatingController.totalBalanceUSD.value.toStringAsFixed(2),
                                style: GoogleFonts.urbanist(
                                    fontSize: 48.sp,
                                    fontWeight: FontWeight.w700,
                                    color: whiteColor),
                              )),
                              // SizedBox(height: 30.h,),
                              Center(
                                child:Text(
                                    walletCreatingController.userName.value,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w800,
                                        color: whiteColor),
                                  ),
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                height: 1.h,
                                color: isDarkMode ? lightSkyColor : whiteColor,
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => SendScreen());
                                        },
                                        child: Container(
                                          height: 60.h,
                                          width: 60.w,
                                          decoration: const BoxDecoration(
                                              color: whiteColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(isDarkMode
                                                ? "assets/icons/chat2.svg"
                                                : "assets/icons/chat.svg"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Send",
                                        style: GoogleFonts.urbanist(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            color: whiteColor),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => ReceiveView());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60.h,
                                          width: 60.w,
                                          decoration: const BoxDecoration(
                                              color: whiteColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(isDarkMode
                                                ? "assets/icons/receive2.svg"
                                                : "assets/icons/receive.svg"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Receive",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: whiteColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => BuyView());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60.h,
                                          width: 60.w,
                                          decoration: const BoxDecoration(
                                              color: whiteColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(isDarkMode
                                                ? "assets/icons/cart2.svg"
                                                : "assets/icons/cart.svg"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Buy",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: whiteColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => SwapView());
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60.h,
                                          width: 60.w,
                                          decoration: const BoxDecoration(
                                              color: whiteColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: SvgPicture.asset(isDarkMode
                                                ? "assets/icons/Swap2.svg"
                                                : "assets/icons/Swap.svg"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "Swap",
                                          style: GoogleFonts.urbanist(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: whiteColor),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      // Remaining content below the image
                      Expanded(
                        child: Container(
                          color: isDarkMode
                              ? lightBlackColor3
                              : whiteColor, // Rest of the screen's background color
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                  dividerHeight: 2,
                                  dividerColor:
                                      isDarkMode ? lightBlackColor : lightBlack,
                                  padding: EdgeInsets.zero,
                                  indicatorPadding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  controller: _tabController,
                                  indicatorColor:
                                      orange3, // Set indicator color
                                  indicatorWeight:
                                      4.0, // Set thickness of indicator line
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        color: isDarkMode
                                            ? lightGreenColor
                                            : orange3,
                                        width: 3.5.w),
                                    borderRadius: BorderRadius.circular(100.r),
                                    insets: EdgeInsets.symmetric(
                                        horizontal: Get.width /
                                            3.5), // Half of screen width for each tab
                                  ),
                                  labelColor: isDarkMode
                                      ? lightGreenColor
                                      : orange3, // Active tab text color
                                  unselectedLabelColor: isDarkMode
                                      ? greyColor3
                                      : greyColor2, // Inactive tab text color
                                  labelStyle: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  unselectedLabelStyle: GoogleFonts.urbanist(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  tabs: const [
                                    Tab(text: 'Tokens'),
                                    Tab(text: 'NFTs'),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Expanded(
                                  child: TabBarView(

                                    controller: _tabController,
                                    children: [
                                      Obx(() {
                                        return walletCreatingController
                                                .tokenData.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    "No Tokens To Display"))
                                            : SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        itemCount:
                                                            walletCreatingController
                                                                .tokenData
                                                                .length,
                                                        shrinkWrap: true,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemBuilder:
                                                            (context, index) {
                                                          final token =
                                                              walletCreatingController
                                                                      .tokenData[
                                                                  index];
                                                          // final balances=walletCreatingController.coinBalances[index];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  TokenDetailsScreen(
                                                                    token:
                                                                        token,
                                                                  ));
                                                            },
                                                            child: Container(
                                                              // height: 80.h,
                                                              width: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  border: Border(
                                                                      bottom: BorderSide(
                                                                          color: isDarkMode
                                                                              ? lightBlackColor
                                                                              : lightBlack))),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15.h),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          45.h,
                                                                      width:
                                                                          35.w,
                                                                      child:
                                                                          Center(
                                                                        child: token.logoUrl.isNotEmpty
                                                                            ? Image.network(
                                                                                token.logoUrl,
                                                                              )
                                                                            : const Icon(Icons.currency_bitcoin),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          15.w,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: Get.width/3,
                                                                          child: Text(
                                                                            token
                                                                                .name,
                                                                            style: GoogleFonts.urbanist(
                                                                                fontSize: 20.sp,
                                                                                fontWeight: FontWeight.w700,
                                                                                color: isDarkMode ? whiteColor : blackColor2),
                                                                                  maxLines: null,
                                                                            //overflow: TextOverflow.visible, // or TextOverflow.visible
                                                                            softWrap: true,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "\$${token.priceInUsd.toStringAsFixed(8)}",
                                                                              style: GoogleFonts.urbanist(fontSize: 14.sp, fontWeight: FontWeight.w800, color: isDarkMode ? greyColor : greyColor3),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10.w,
                                                                            ),
                                                                            Text(
                                                                              // coin.contractAddress,
                                                                              token.trendPercentage.toStringAsFixed(2),
                                                                              style: GoogleFonts.urbanist(
                                                                                  fontSize: 12.sp,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: token.trendPercentage.toStringAsFixed(2).startsWith('-')
                                                                                      ? pinkColor
                                                                                      : isDarkMode
                                                                                          ? lightGreenColor
                                                                                          : orange3),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                      SizedBox(
                                                                        width: Get.width/3,
                                                                        child: Text(
                                                                        textAlign: TextAlign.end,
                                                                           !token.balance.toString().startsWith("0.000")?                                                              
                                                                          "${token.balance.toStringAsFixed(3)} ${token.symbol}":!token.balance.toString().startsWith("0.00000")?
                                                                          "${token.balance.toStringAsFixed(6)} ${token.symbol}":  "${token.balance.toStringAsFixed(8)} ${token.symbol}",
                                                                          style: GoogleFonts.urbanist(
                                                                              fontSize: 18.sp,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: isDarkMode ? whiteColor : blackColor2),
                                                                                maxLines: null,
                                                                          overflow: TextOverflow.visible, // or TextOverflow.visible
                                                                          softWrap: true,
                                                                        ),
                                                                      ),
                                                                        Text(
                                                                          "\$${token.balanceInUsd.toStringAsFixed(2)}",
                                                                          style: GoogleFonts.urbanist(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.w800,
                                                                              color: isDarkMode ? greyColor : greyColor3),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                    SizedBox(
                                                      height: 25.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(() =>
                                                             AddTokenScreen());
                                                      },
                                                      child: Container(
                                                        height: 45.h,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100.r),
                                                            border: Border.all(
                                                                color: isDarkMode
                                                                    ? lightGreenColor
                                                                    : orange3)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                                width: 20.h,
                                                                height: 20.w,
                                                                child: Center(
                                                                    child: SvgPicture
                                                                        .asset(
                                                                  "assets/icons/plusIcon.svg",
                                                                  colorFilter: ColorFilter.mode(
                                                                      isDarkMode
                                                                          ? lightGreenColor
                                                                          : orange3,
                                                                      BlendMode
                                                                          .srcIn),
                                                                ))),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Text(
                                                              "Add Token",
                                                              style: GoogleFonts.urbanist(
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: isDarkMode
                                                                      ? lightGreenColor
                                                                      : orange3),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                      }),
                                      Obx(() {
                                        return
                                        nftController.isLoading.value? Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: 6, // Number of shimmer items
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.64.h,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(28.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 154,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 18.h,
                      width: 100.w,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Container(
                          height: 12.h,
                          width: 60.w,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 12.h,
                          width: 13.w,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ):
                                         nftController.showImportednfts.value==false
                                            ? Column(
                                                children: [
                                                  Image.asset(
                                                    isDarkMode
                                                        ? "assets/images/NFT8.png"
                                                        : "assets/images/NFT.png",
                                                    height: 180.h,
                                                    width: 180.w,
                                                  ),
                                                 Visibility(
                                                   visible: nftController.nftList.isEmpty,
                                                  child:  SizedBox(
                                                    height: 20.h,
                                                  ),),
                                                 Obx((){
                                                  return
                                                  nftController.nftList.isEmpty?
                                                   Text(
                                                    "No NFTs Yet",
                                                    style: GoogleFonts.urbanist(
                                                        fontSize: 24.sp,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: isDarkMode
                                                            ? greyColor
                                                            : darkGreyColor),
                                                  ):GestureDetector(
                                                    onTap: (){
                                                      nftController.showImportednfts.value=true;
                                                    },
                                                    child: Text(
                                                      "Show imporetd NFTs",
                                                      style: GoogleFonts.urbanist(
                                                          fontSize: 24.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDarkMode
                                                              ? greyColor
                                                              : darkGreyColor),
                                                    ),
                                                  );
                                                 }),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                           ImportNFTScreen());
                                                    },
                                                    child: Text(
                                                      "Import NFTs",
                                                      style: GoogleFonts.urbanist(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDarkMode
                                                              ? lightGreenColor
                                                              : orange3),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : NftGridView();
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ],
                  );
          })),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildShimmerLayout(bool isDarkMode) {
    return Column(
      children: [
        // Top Container with background image
        Container(
          width: double.infinity,
          height: Get.height / 2.5.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDarkMode ? "assets/images/home2.png" : topYellow,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 50.h, left: 25.w, right: 25.w, bottom: 30.h),
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor:
                  isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row Icons
                  Row(
                    children: [
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Container(
                        height: 28.h,
                        width: 28.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  // Balance
                  Container(
                    height: 48.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  // Username
                  Container(
                    height: 18.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  // Divider
                  Container(
                    height: 1.h,
                    color: Colors.white,
                  ),
                  // Bottom Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      4,
                      (index) => Column(
                        children: [
                          Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            height: 18.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bottom Section
        Expanded(
          child: Container(
            color: isDarkMode ? lightBlackColor3 : whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Shimmer.fromColors(
                baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                highlightColor:
                    isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
                child: Column(
                  children: [
                    // Tab Bar Shimmer
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Token List Shimmer
                    Expanded(
                      child: ListView.builder(
                        
                        padding: EdgeInsets.zero,
                        itemCount: 6, // Number of shimmer items
                        shrinkWrap: true,
                        
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color:
                                      isDarkMode ? lightBlackColor : lightBlack,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Token Icon
                                Container(
                                  height: 45.h,
                                  width: 35.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                // Token Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Container(
                                            height: 14.h,
                                            width: 60.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Container(
                                            height: 14.h,
                                            width: 40.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Balance Column
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 18.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      height: 14.h,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Add Token Button Shimmer
                    SizedBox(height: 25.h),
                    Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
