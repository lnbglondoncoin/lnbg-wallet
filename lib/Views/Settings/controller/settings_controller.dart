import 'package:get/get.dart';

class SettingsController extends GetxController{
  List settingIcons=[
    "assets/icons/wallets.png",
     "assets/icons/general.png",
      "assets/icons/security.png",
       "assets/icons/advance.png",
        "assets/icons/darkMode.png",
         "assets/icons/contacts.png",
          "assets/icons/notifications5.png",
           "assets/icons/helpc.png",
            "assets/icons/invite.png",
             "assets/icons/about.png",
 ];

   List settingLabels=[
    "Wallets",
     "General",
      "Security & Privacy",
       "Advanced",
        "Dark Mode",
         "Contacts",
          "Notification",
           "Help Center",
            "Invite Friends",
             "About LNBG Wallet",
 ];
 RxBool isSwitched=false.obs;
}