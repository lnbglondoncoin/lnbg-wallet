import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/controller/contact_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/add_contact.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/shimmer_app_bar_widget.dart';
import 'package:shimmer/shimmer.dart';

class ContactsView extends StatelessWidget {
  ContactsView({super.key});
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
       appBar:  PreferredSize(preferredSize:  const Size.fromHeight(kToolbarHeight), child: Obx((){
        return controller.isLoading.value?ShimmerAppBar(isDarkMode: isDarkMode):CustomAppBar(
        title: "Contacts".tr,
        iconPath: "assets/icons/plusIcon.svg",
        isSuffix: false,
        onSuffixTap: () {
          Get.toNamed(AppRoutes.addContact);
        },
      );
      })),
      
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (controller.isLoading.value) {
           return ListView.builder(
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
          // Name shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16.h,
                    width: 180.w,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
          } else if (controller.contacts.isEmpty) {
            return Center(child: Text("No contacts found".tr));
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              var contact = controller.contacts[index];
              return ListTile(
                minVerticalPadding: 10.h,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  child: Text(contact.displayName != null && contact.displayName!.isNotEmpty
                      ? contact.displayName!.characters.first
                      : "?"),
                ),
                title: Text(contact.displayName ?? "Unknown",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: isDarkMode ? whiteColor : blackColor2)),
                // subtitle: Text(
                //   contact.phones?.isNotEmpty == true
                //       ? contact.phones!.first.value ?? "No number"
                //       : "No number",
                //   style: GoogleFonts.urbanist(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 16.sp,
                //       color: isDarkMode ? greyColor : greyColor3),
                // ),
              );
            },
          );
        }),
      ),
    );
  }
}
