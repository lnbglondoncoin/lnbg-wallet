import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/controller/nft_controller.dart';


class NftGridView extends StatelessWidget {
  final NftController controller = Get.put(NftController());

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
         ListTile(
          contentPadding: EdgeInsets.zero,
          leading:CircleAvatar(
            radius: 15.r,
            backgroundImage: AssetImage("assets/images/nek.png"), // Change as needed
          ) ,
        title: Text("Nekochimin",style: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: whiteColor 
        ),), 
        trailing: SvgPicture.asset("assets/icons/arrowUp.svg"),
         ),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.w),
              child:  GridView.builder(
                padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    childAspectRatio: 0.65, // Adjust as needed
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.nftList.length,
                  itemBuilder: (context, index) {
                    var nft = controller.nftList[index];
                    return Card(
                      color: whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.asset(nft.imageUrl, width: double.infinity, height: 154),
                            ),
                            //const SizedBox(height: 10),
                            Text(
                              "${nft.name} #${nft.id}",
                              style: GoogleFonts.urbanist(color: blackColor2,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,),
                            ),
                             SizedBox(height: 10.h),
                            Row(
                              children: [
                                 Text(
                                  "Nekochimin",
                                  style: GoogleFonts.urbanist(color: greyColor3,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,),
                                ),
                                SizedBox(width: 10.w),
                                SvgPicture.asset("assets/icons/approve.svg",height: 12.h,width: 13.w,)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ),
          ),
        ],
      );
 
  }
}
