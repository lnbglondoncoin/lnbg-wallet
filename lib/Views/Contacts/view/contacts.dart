import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/controller/contact_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/add_contact.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';

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
      appBar: CustomAppBar(
        title: "Contacts",
        iconPath: "assets/icons/plusIcon.svg",
        isSuffix: true,
        onSuffixTap: () {
          Get.to(() => const AddContact());
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.contacts.length,
              itemBuilder: (context, index) {
                var contact = controller.contacts[index];
                return ListTile(
                  minTileHeight: 70.h,
                  contentPadding: EdgeInsets.zero,
                  leading:
                      Image.asset(contact.imageUrl, width: 48.w, height: 48.h),
                  title: Text(contact.name,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: isDarkMode ? whiteColor : blackColor2)),
                  subtitle: Text(
                      maxLines: 1,
                      contact.id,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: isDarkMode ? greyColor : greyColor3)),
                );
              },
            )),
      ),
    );
  }
}
