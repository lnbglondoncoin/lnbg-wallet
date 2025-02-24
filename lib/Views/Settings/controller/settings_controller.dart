import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/theme_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/AboutLNBG/view/about_lnbg_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/AdvanceSettings/view/advance_setting_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/contacts.dart';
import 'package:lnbg_crypto_wallet_app/Views/GeneralSettings/view/general_settings_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/HelpCenter/view/help_center_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/InviteFreinds/view/invite_friend.dart';
import 'package:lnbg_crypto_wallet_app/Views/NotificationSettings/view/notification_settings.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/security_and_privacy.dart';
import 'package:lnbg_crypto_wallet_app/Views/Wallets/view/wallet_view.dart';

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
//   var theme = Theme.of(context);
//    bool isDarkMode =
//         theme.brightness == Brightness.dark; // Check if dark mode is active

//  RxBool isSwitched=isDark false.obs; 
 settingActions(index){
  if(index==0){
    Get.to(()=>WalletScreen()); 
  }
  else if(index==2){
    Get.to(()=>SecurityAndPrivacyView());
  }
  else if(index==1){
    Get.to(()=>GenralSettingsView());
  }
  else if(index==4){
 
  }
else if(index==5){
  Get.to(()=>ContactsView());
}
else if(index==3){
  Get.to(()=>AdvanceSettingView());
}
else if(index==8){
  Get.to(()=>InviteFriend());
}
else if(index==6){
  Get.to(()=>NotificationSettingsView());
}
else if(index==9){
  Get.to(()=>AboutLNBG());
}
else if(index==7){
  Get.to(()=>HelpCenterScreen()); 
}
 }
}