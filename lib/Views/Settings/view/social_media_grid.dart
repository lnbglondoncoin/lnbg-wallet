import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';

class SocialMediaGrid extends StatelessWidget {
  final List<Map<String, dynamic>> socialMedia = [
    {"icon": "assets/icons/twitter.svg", "name": "Twitter", "color": blueColor},
    {"icon": "assets/icons/instagram.svg", "name": "Instagram", "color": pinkColor2},
    {"icon": "assets/icons/discord.svg", "name": "Discord", "color": blueColor2},
    {"icon": "assets/icons/reddit.svg", "name": "Reddit", "color": orangeColor},
    {"icon": "assets/icons/telegram.svg", "name": "Telegram", "color": blueColor3},
    {"icon": "assets/icons/youtube.svg", "name": "YouTube", "color": redColor2},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    
        crossAxisCount: 3, // 3 columns
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemCount: socialMedia.length,
      itemBuilder: (context, index) {
        return SocialMediaButton(
          iconPath: socialMedia[index]["icon"],
          name: socialMedia[index]["name"],
          color: socialMedia[index]["color"],
        );
      },
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String iconPath;
  final String name;
  final Color color;

  const SocialMediaButton({
    required this.iconPath,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, width: 25.w, height: 25.h, colorFilter: ColorFilter.mode(whiteColor, BlendMode.srcIn)),
          SizedBox(height: 10.h),
          Text(
            name,
            style: GoogleFonts.urbanist(color: whiteColor, fontWeight: FontWeight.w700,fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
