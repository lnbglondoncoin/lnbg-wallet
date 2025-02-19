import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Browse/view/clear_history_bottomsheet.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class BrowseHistoryScreen extends StatelessWidget {
  final List historyItems;
  const BrowseHistoryScreen({super.key, required this.historyItems});

  @override
  Widget build(BuildContext context) {
      var theme = Theme.of(context);
      var textTheme = theme.textTheme;
      bool isDarkMode =
          theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
         backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(title: "History", iconPath: "assets/icons/delete.svg",isSuffix: true, onSuffixTap: () {
  _showCustomBottomSheet(context);
   
  },),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: historyItems.length,
          itemBuilder: (context,index){
           final item = historyItems[index];
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Image.asset(item.imagePath, width: 48.w, height: 48.h),
                  title: Text(item.name, style:  GoogleFonts.urbanist(fontWeight: FontWeight.w700,fontSize: 20.sp,color:isDarkMode?whiteColor: blackColor2)),
                  subtitle: Text(item.description, overflow: TextOverflow.ellipsis,style: GoogleFonts.urbanist(fontWeight: FontWeight.w800,fontSize: 14.sp,color:isDarkMode?greyColor: greyColor3),),
                  onTap: () {
                    // Handle tap if needed
                  },
                ),
                Visibility(
                  visible: index!=historyItems.length-1,
                  child: CustomDivider())
              ],
            );
        }),
      ),
    );
  }
  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen height
      backgroundColor: Colors.transparent, // Transparent background
      builder: (context) {
        return const ClearHistoryBottomSheet();
      },
    );
  }
}