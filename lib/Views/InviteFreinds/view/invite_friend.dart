import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/controller/contact_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/InviteFreinds/Controller/invite_friend_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class InviteFriend extends StatelessWidget {
  InviteFriend({super.key});
  final controller = Get.put(InviteFriendController());
  final contactController = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
       appBar:  PreferredSize(preferredSize:  const Size.fromHeight(kToolbarHeight), child: Obx((){
        return contactController.isLoading.value?ShimmerAppBar(isDarkMode: isDarkMode):CustomAppBar(
        title: "Invite Friends".tr,
        iconPath: "assets/icons/plusIcon.svg",
      );
      })),
    
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child:Obx((){
           if (contactController.isLoading.value) {
            return  ListView.builder(
              shrinkWrap: true,
  itemCount: 10,
  itemBuilder: (context, index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          // Circle shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(width: 16.w),
          // Name and phone shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16.h,
                    width: 150.w,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(height: 8.h),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14.h,
                    width: 100.w,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          // Button shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 32.h,
              width: 89.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
          } else if (contactController.contacts.isEmpty) {
            return Center(child: Text("No contacts found".tr));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: contactController.contacts.length,
            itemBuilder: (context, index) {
                var contact = contactController.contacts[index];

              return ListTile(
             
                
                //minTileHeight: 70.h,
                contentPadding: EdgeInsets.zero,
               leading: CircleAvatar(
                backgroundColor: isDarkMode?lightGreenColor.withValues(alpha: 0.3):orange3.withValues(alpha: 0.3),
                //radius: 48.h,
                  child: Text(contact.displayName != null && contact.displayName!.isNotEmpty
                      ? contact.displayName!.characters.first
                      : "?"),
                ),
                title: Text(
                  contact.displayName!,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: isDarkMode ? whiteColor : blackColor2,
                  ),
                ),
                subtitle: Text(
                  contact.phones != null && contact.phones!.isNotEmpty
                      ? contact.phones!.map((e) => e.value).join(", ")
                      : "No phone numbers",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: isDarkMode ? greyColor : greyColor3,
                  ),
                ),
               trailing: SizedBox(
  width: 89.w, // or slightly less if needed like 80.w
  child: GestureDetector(
    onTap: () {
      if (contact.phones != null && contact.phones!.isNotEmpty) {
        final phoneNumber = contact.phones!.first.value;
        if (phoneNumber != null) {
          controller.inviteContact(phoneNumber);
        }
      }
    },
    child: Container(
        height: 32.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDarkMode ? lightGreenColor : orange3,
            width: 2.h,
          ),
          borderRadius: BorderRadius.circular(100.r),
          color: isDarkMode ? lightGreenColor : orange3,
        ),
        child: Center(
          child: Text(
            "Invite".tr,
            style: GoogleFonts.urbanist(
              fontSize: 14.sp,
              fontWeight: FontWeight.w800,
              color: whiteColor,
            ),
          ),
        ),
      )
  ),
),

              );
            },
          );
        })
      ),
    );
  }
}
