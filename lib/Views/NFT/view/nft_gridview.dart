import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/controller/nft_controller.dart';
import 'package:shimmer/shimmer.dart';

class NftGridView extends StatelessWidget {
  final NftController controller = Get.put(NftController());

  NftGridView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 15.r,
            backgroundImage:
                const AssetImage("assets/images/nek.png"), // Change as needed
          ),
          title: Text(
            "NFTs",
            style: GoogleFonts.urbanist(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? whiteColor : blackColor2),
          ),
          trailing: GestureDetector(
            onTap: (){
              controller.showImportednfts.value=!controller.showImportednfts.value;
            },
            child: SvgPicture.asset(
              "assets/icons/arrowUp.svg",
              colorFilter: ColorFilter.mode(
                  isDarkMode ? lightGreenColor : orange3, BlendMode.srcIn),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                childAspectRatio: 0.64.h, // Adjust as needed
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.nftList.length,
              itemBuilder: (context, index) {
                var nft = controller.nftList[index];
                  // Convert IPFS URL to HTTP URL
                String imageUrl = nft.image.replaceFirst("ipfs://", "https://ipfs.io/ipfs/");

                return Card(
                  color: isDarkMode ? lightBlackColor2 : whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  elevation: 8,
                  shadowColor: lightBlackColor.withValues(alpha: 0.3),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
FutureBuilder<String>(
  future: controller.getImageUrlFromIpfs(nft.image),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 154,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      );
    } else if (snapshot.hasError) {
      return Container(
        height: 154,
        width: double.infinity,
        color: Colors.grey.shade300,
        child: Center(child: Icon(Icons.error)),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Image.network(
          snapshot.data!,
          width: double.infinity,
          height: 154,
          fit: BoxFit.cover,
        ),
      );
    }
  },
),

                        //const SizedBox(height: 10),
                        Text(
                          "${nft.name} #${nft.collectibleId}",
                          style: GoogleFonts.urbanist(
                            color: isDarkMode ? whiteColor : blackColor2,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                              "${nft.collectionName}",
                              style: GoogleFonts.urbanist(
                                color: isDarkMode ? greyColor : greyColor3,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SvgPicture.asset(
                              "assets/icons/approve.svg",
                              height: 12.h,
                              width: 13.w,
                            )
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
