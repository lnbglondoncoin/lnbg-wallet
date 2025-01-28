import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';  // Import for status bar styling
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/constant_list.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/Buy/view/buy_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Notifications/view/notification_screen.dart';
import 'package:lnbg_crypto_wallet_app/Views/Receive/view/receive_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/ScanQRCode/view/scan_code.dart';
import 'package:lnbg_crypto_wallet_app/Views/Send/view/send_screen.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> with SingleTickerProviderStateMixin {
   late TabController _tabController;
   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,  // Make status bar transparent
        statusBarIconBrightness: Brightness.light,  // Adjust icons for visibility
      ),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
          children: [
            // Image covering only the top area (including the status bar)
            Container(
              width: double.infinity,
              height: Get.height/2.5.h, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(topYellow),
                  fit: BoxFit.cover,  // Cover only the given height
                ),
              ),
              child: Padding(
                padding:  EdgeInsets.only(top:50.h,left: 25.w,right: 25.w,bottom: 30.h ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 28.h,
                          width: 28.w,
                          child: Center(
                            child: SvgPicture.asset(eyeShowIcon,colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn),
                                                  
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>ScanQRCodeScreen());
                          },
                          child: SizedBox(
                              height: 28.h,
                            width: 28.w,
                            child: Center(child: SvgPicture.asset(scanIcon,colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn)))),
                        ),
SizedBox(width: 15.w,),
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>NotificationScreen());
                          },
                          child: SizedBox(
                              height: 28.h,
                            width: 28.w,
                            child: Center(child: SvgPicture.asset(notification,colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn)))),
                        ),
                      ],
                    ),
               // SizedBox(height: 30.h,),
                Center(
                  child: Text("\$99,677.55",style: GoogleFonts.urbanist(fontSize: 48.sp,
                  fontWeight: FontWeight.w700,
                  color: whiteColor),),
                ),
                 // SizedBox(height: 30.h,),
                Center(
                  child: Text("AndrewAinsley",style: GoogleFonts.urbanist(fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                  color: whiteColor),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=>SendScreen());
                          },
                          child: Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: 
                              SvgPicture.asset("assets/icons/chat.svg"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text("Send",style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: whiteColor
                        ),)
                      ],
                    ),
                     GestureDetector(
                      onTap: (){
                        Get.to(()=>ReceiveView());
                      },
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: 
                              SvgPicture.asset("assets/icons/receive.svg"),
                            ),
                                               ),
                                                SizedBox(height: 10.h,),
                                                Text("Receive",style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: whiteColor
                          ),)
                         ],
                       ),
                     ),
                     GestureDetector(
                      onTap: (){
                        Get.to(()=>BuyView());
                      },
                       child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Container(
                            height: 60.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.circle
                            ),
                            child: Center(
                              child: 
                              SvgPicture.asset("assets/icons/cart.svg"),
                            ),
                                               ),
                                                SizedBox(height: 10.h,),
                                                Text("Buy",style: GoogleFonts.urbanist(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: whiteColor
                          ),)
                         ],
                       ),
                     ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle
                          ),
                          child: Center(
                            child: 
                            SvgPicture.asset("assets/icons/Swap.svg"),
                          ),
                                             ),
                                              SizedBox(height: 10.h,),
                                              Text("Swap",style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: whiteColor
                        ),)
                       ],
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
                color: whiteColor, // Rest of the screen's background color
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TabBar(
                              dividerHeight: 2,
                              dividerColor: lightBlack,
                              padding: EdgeInsets.zero,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              controller: _tabController,
                              indicatorColor: orange3,  // Set indicator color
                              indicatorWeight: 4.0,  // Set thickness of indicator line
                               indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(color: orange3, width: 3.5.w),
                                borderRadius: BorderRadius.circular(100.r),
                                insets: EdgeInsets.symmetric(horizontal: Get.width / 3.5), // Half of screen width for each tab
                              ),
                              labelColor: orange3,  // Active tab text color
                              unselectedLabelColor: greyColor2,  // Inactive tab text color
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
                                children:  [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                                                  
                                                                  ListView.builder(
                                                                    itemCount: tokenIconList.length,
                                                                    shrinkWrap: true,
                                                                    physics: BouncingScrollPhysics(),
                                                                    itemBuilder: (context,index){
                                                                    return         
                                                                    Container(
                                       // height: 80.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: lightBlack
                                            )
                                          )
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 15.h),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 45.h,
                                                width: 35.w,
                                                child: Center(
                                                  child: Image.asset(tokenIconList[index],
                                                  ),
                                                ),
                                              ),
                                             
                                             SizedBox(width: 15.w,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(tokenList[index],style: GoogleFonts.urbanist(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: blackColor2
                                                  ),),
                                                  Row(
                                                    children: [
                                                      Text(tokenCoinndolorPriceWithPercentage[index],style: GoogleFonts.urbanist(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w800,
                                                        color: greyColor3
                                                      ),),
                                                    SizedBox(width: 10.w,),
                                                      Text(tokenPercentage[index],style: GoogleFonts.urbanist(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color:tokenPercentage[index].startsWith('-')? pinkColor:orange3
                                                  ),) 
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              
                                              Spacer(),
                                               Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(tokenCoinPrice[index],style: GoogleFonts.urbanist(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: blackColor2
                                                  ),),
                                                  Text(tokenCoinndolorPrice[index],style: GoogleFonts.urbanist(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w800,
                                                        color: greyColor3
                                                      ),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        );
                                    
                                                                  }),
                                                                  SizedBox(
                                                                    height: 25.h,
                                                                  ),
                                                                  Container(
                                                                    height: 45.h,
                                                                    width: double.infinity,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(100.r),
                                                                      border: Border.all(
                                                                        color: orange3
                                                                      )
                                                                    ),
                                                                    child:Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 20.h,
                                                                          height: 20.w,
                                                                          child: Center(child: SvgPicture.asset("assets/icons/plusIcon.svg"))),
                                                                        SizedBox(width: 2.w,),  
                                                                        Text("Add Token",style: GoogleFonts.urbanist(
                                                                          fontSize: 18.sp,
                                                                          fontWeight: FontWeight.w700,
                                                                          color: orange3
                                                                        ),)
                                                                      ],
                                                                    ),
                                                                  )
                                                                    ],
                                    ),
                                  ),
                                  Center(child: Text('NFTs Content')),
                                ],
                              ),
                            ),
                          ],
                        ),
                  )
                ),
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
