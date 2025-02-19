import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/add_contact.dart';
import 'package:lnbg_crypto_wallet_app/Views/InviteFreinds/Controller/invite_friend_controller.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

class InviteFriend extends StatelessWidget {
  InviteFriend({super.key});
  final controller = Get.put(InviteFriendController());

  @override
  Widget build(BuildContext context) {
        var theme = Theme.of(context);
    var textTheme = theme.textTheme;
       bool isDarkMode = theme.brightness == Brightness.dark; // Check if dark mode is active
    return Scaffold(
      backgroundColor:isDarkMode?lightBlackColor3:whiteColor,
      appBar: CustomAppBar(
        title: "Invite Friends",
        iconPath: "assets/icons/plusIcon.svg",
       
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              var contact = controller.contacts[index];


              return ListTile(
                minTileHeight: 70.h,
                contentPadding: EdgeInsets.zero,
                leading: Image.asset(contact.imageUrl, width: 48.w, height: 48.h),
                title: Text(
                  contact.name,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color:isDarkMode?whiteColor: blackColor2,
                  ),
                ),
                subtitle: Text(
                  contact.id,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color:isDarkMode?greyColor: greyColor3,
                  ),
                ),
                trailing: GestureDetector(
                onTap: () => controller.toggleContact(index),
                  child: Obx((){
                    return Container(
                    height: 32.h,
                    width: 89.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:isDarkMode?lightGreenColor: orange3,
                        width: 2.h
                      ),
                      borderRadius: BorderRadius.circular(100.r),

                      color:controller.selectedIndices.contains(index) ? Colors.transparent : isDarkMode?lightGreenColor: orange3,
                    ),
                    child: Center(
                      child: Text(
                       controller.selectedIndices.contains(index)? "Invited":"Invite",
                        style: GoogleFonts.urbanist(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: controller.selectedIndices.contains(index)?isDarkMode?lightGreenColor:  orange3:whiteColor,
                        ),
                      ),
                    ),
                  );
                  })
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
