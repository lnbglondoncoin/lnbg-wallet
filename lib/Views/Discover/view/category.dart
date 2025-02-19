import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/controller/descover_controlelr.dart';
import 'package:lnbg_crypto_wallet_app/Views/Discover/view/coin_properties.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class CoinsCategoryScreen extends StatelessWidget {
  final String category;
  final List cryptos;
   CoinsCategoryScreen({super.key, required this.category, required this.cryptos});
 final DiscoverController controller = Get.put(DiscoverController());
  @override
  Widget build(BuildContext context) {
      var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(title: category, iconPath: "assets/icons/search.svg",isSuffix: true,),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          shrinkWrap: true,
        itemCount: cryptos.length,
          itemBuilder: (context,index){
          var crypto=cryptos[index];
          //  var cryptos = controller.cryptoList[indexx];
          //  var crypto=cryptos[index];
          return GestureDetector(
            onTap: (){
              Get.to(()=>CoinProperties(crypto: crypto,));
            },
            child: Container(
                            decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:isDarkMode?lightBlackColor: greyColor
                      )
                    )
                  ),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(vertical: 5.h),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor:Colors.transparent,
                                  backgroundImage: AssetImage(crypto.imageUrl),
                                ),
                                title: category=='Staking'? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${crypto.name} (${crypto.symbol})",
                              style: GoogleFonts.urbanist(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color:isDarkMode?whiteColor: blackColor2,
                              ),
                            ),Row(
                            children: [
                              Text("APR:",style: GoogleFonts.urbanist(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w800,
                                color:isDarkMode?greyColor: greyColor3
                              ),),
                              SizedBox(width: 5.w,),
                               Text(
                                "${crypto.percentage}%",
                                style: GoogleFonts.urbanist(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: crypto.percentage.startsWith('+') ? skyColor : pinkColor,
                                ),
                              ),
                            ],
                          ),
                            
                          ],
                        ): Text(
                          "${crypto.name} (${crypto.symbol})",
                          style: GoogleFonts.urbanist(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color:isDarkMode?whiteColor: blackColor2,
                          ),
                        ),
                               
                                trailing: Visibility(
                                  visible:  category!='Staking',
                                  child: 
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("\$${crypto.price.toStringAsFixed(2)}",style: GoogleFonts.urbanist(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color:isDarkMode?whiteColor: blackColor2
                                ),),
                                     Text( "${crypto.percentage}%",style: GoogleFonts.urbanist(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                   color: crypto.percentage.startsWith('+') ? skyColor : pinkColor, 
                                ),),
                                  ],
                                ),)
                              ),
                            ),
                          ),
          );
        }),
      ),
    );
  }
}