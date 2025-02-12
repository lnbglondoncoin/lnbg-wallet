import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
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
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final nftController=Get.put(NftController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // Make status bar transparent
        statusBarIconBrightness:
            Brightness.light, // Adjust icons for visibility
      ),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Column(
          children: [
            // Image covering only the top area (including the status bar)
            Container(
              width: double.infinity,
              height: Get.height / 2.5.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isDarkMode ? "assets/images/home2.png" : topYellow,
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
                      children: [
                        SizedBox(
                          height: 28.h,
                          width: 28.w,
                          child: Center(
                            child: SvgPicture.asset(
                              eyeShowIcon,
                              colorFilter: const ColorFilter.mode(
                                  whiteColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ScanQRCodeScreen());
                          },
                          child: SizedBox(
                              height: 28.h,
                              width: 28.w,
                              child: Center(
                                  child: SvgPicture.asset(scanIcon,
                                      colorFilter: const ColorFilter.mode(
                                          whiteColor, BlendMode.srcIn)))),
                        ),
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
                                  child: SvgPicture.asset(notification,
                                      colorFilter: const ColorFilter.mode(
                                          whiteColor, BlendMode.srcIn)))),
                        ),
                      ],
                    ),
                    // SizedBox(height: 30.h,),
                    Center(
                      child: Text(
                        "\$99,677.55",
                        style: GoogleFonts.urbanist(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                            color: whiteColor),
                      ),
                    ),
                    // SizedBox(height: 30.h,),
                    Center(
                      child: Text(
                        "AndrewAinsley",
                        style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: whiteColor),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      height: 1.h,
                      color: whiteColor,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const SendScreen());
                              },
                              child: Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: const BoxDecoration(
                                    color: whiteColor, shape: BoxShape.circle),
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
                            Get.to(() => const ReceiveView());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: const BoxDecoration(
                                    color: whiteColor, shape: BoxShape.circle),
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
                            Get.to(() => const BuyView());
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: const BoxDecoration(
                                    color: whiteColor, shape: BoxShape.circle),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                decoration: const BoxDecoration(
                                    color: whiteColor, shape: BoxShape.circle),
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
                color: theme
                    .scaffoldBackgroundColor, // Rest of the screen's background color
                child: Center(
                    child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        dividerHeight: 2,
                        dividerColor: isDarkMode ? lightBlackColor : lightBlack,
                        padding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        controller: _tabController,
                        indicatorColor: orange3, // Set indicator color
                        indicatorWeight: 4.0, // Set thickness of indicator line
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: isDarkMode ? lightGreenColor : orange3,
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
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      itemCount: tokenIconList.length,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.to(TokenDetailsScreen(
                                              coinIconPath: tokenIconList[index],
                                              coinName: tokennameList[index],
                                              tokenPrice:    tokenCoinndolorPriceWithPercentage[
                                                                index],
                                              percentage:  tokenPercentage[
                                                                index],
                                              prceInTokenshortWord:   tokenCoinPrice[index],
                                              priceDolor: tokenCoinndolorPrice[index],
                                            ));
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15.h),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 45.h,
                                                    width: 35.w,
                                                    child: Center(
                                                      child: Image.asset(
                                                        tokenIconList[index],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        tokennameList[index],
                                                        style: GoogleFonts.urbanist(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: isDarkMode
                                                                ? whiteColor
                                                                : blackColor2),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            tokenCoinndolorPriceWithPercentage[
                                                                index],
                                                            style: GoogleFonts.urbanist(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: isDarkMode
                                                                    ? greyColor
                                                                    : greyColor3),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            tokenPercentage[
                                                                index],
                                                            style: GoogleFonts
                                                                .urbanist(
                                                                    fontSize:
                                                                        12.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: tokenPercentage[index]
                                                                            .startsWith('-')
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
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        tokenCoinPrice[index],
                                                        style: GoogleFonts.urbanist(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: isDarkMode
                                                                ? whiteColor
                                                                : blackColor2),
                                                      ),
                                                      Text(
                                                        tokenCoinndolorPrice[
                                                            index],
                                                        style: GoogleFonts
                                                            .urbanist(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
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
                                        );
                                      }),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>AddTokenScreen());
                                    },
                                    child: Container(
                                      height: 45.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          border: Border.all(
                                              color: isDarkMode
                                                  ? lightGreenColor
                                                  : orange3)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: 20.h,
                                              height: 20.w,
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                "assets/icons/plusIcon.svg",
                                                colorFilter: ColorFilter.mode(
                                                    isDarkMode
                                                        ? lightGreenColor
                                                        : orange3,
                                                    BlendMode.srcIn),
                                              ))),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            "Add Token",
                                            style: GoogleFonts.urbanist(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
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
                            ),
                     Obx((){
                      return    
                      nftController.nftList.isEmpty?
                         Column(
                            children: [
                              Image.asset("assets/images/NFT.png",height: 180.h,
                              width: 180.w,),
                              SizedBox(height: 20.h,),
                              Text("No NFTs Yet",
                                            style: GoogleFonts.urbanist(
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w700,
                                                color:darkGreyColor),
                                          ),
                                           SizedBox(height: 10.h,),
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>ImportNFTScreen());
                                },
                                child: Text("Import NFTs",
                                              style: GoogleFonts.urbanist(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color:orange3),
                                            ),
                              )
                            ],
                           ):NftGridView();
                          
                     })],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
