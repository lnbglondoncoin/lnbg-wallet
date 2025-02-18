  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/controller/contact_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/add_contact.dart';
  import 'package:lnbg_crypto_wallet_app/Views/Wallets/controller/wallet_controller.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
  import 'package:lnbg_crypto_wallet_app/Widgets/custom_divider.dart';

class ContactsView extends StatelessWidget {
   ContactsView({super.key});
  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(title: "Contacts", iconPath: "assets/icons/plusIcon.svg", isSuffix: true,
      onSuffixTap: (){
        Get.to(()=>AddContact());
      },),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) {
            var contact=controller.contacts[index];
            return ListTile( 
              minTileHeight: 70.h,
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(contact.imageUrl, width: 48.w, height: 48.h),
                    title: Text(contact.name,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w700, fontSize: 18.sp, color: blackColor2)),
                    subtitle: Text(
                      maxLines: 1,
                      contact.id,
                      overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500, fontSize: 18.sp, color: greyColor3)),
               );
          },
        )),
      ),
    );
  }
}