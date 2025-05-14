import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Routes/app_routes.dart';
import 'package:lnbg_crypto_wallet_app/Views/AboutLNBG/view/about_lnbg_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/AdvanceSettings/view/advance_setting_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/Contacts/view/contacts.dart';
import 'package:lnbg_crypto_wallet_app/Views/GeneralSettings/view/general_settings_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/HelpCenter/view/help_center_view.dart';
import 'package:lnbg_crypto_wallet_app/Views/InviteFreinds/view/invite_friend.dart';
import 'package:lnbg_crypto_wallet_app/Views/NotificationSettings/view/notification_settings.dart';
import 'package:lnbg_crypto_wallet_app/Views/Onboarding/Walkthroughs/view/walkthrough.dart';
import 'package:lnbg_crypto_wallet_app/Views/Security&Privacy/view/security_and_privacy.dart';
import 'package:lnbg_crypto_wallet_app/Views/Wallets/view/wallet_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  List settingIcons = [
   // "assets/icons/wallets.png",
    "assets/icons/general.png",
    "assets/icons/security.png",
   // "assets/icons/advance.png",
    "assets/icons/darkMode.png",
    "assets/icons/contacts.png",
   // "assets/icons/notifications5.png",
    "assets/icons/helpc.png",
    "assets/icons/invite.png",
    "assets/icons/about.png",
    "assets/icons/about.png", //logout
  ];

  var settingLabels = [
   // "Wallets",
    "Language",
    "Security & Privacy",
   // "Advanced",
    "Dark Mode",
    "Contacts",
   // "Notifications",
    "Help Center",
    "Invite Friends",
    "About LNBG Wallet",
    "Logout",
  ].obs;

  settingActions(index) {
    // if (index == 0) {
    //   Get.to(() => WalletScreen());
    // } 
     if (index == 0) {
      Get.toNamed(AppRoutes.genralSettingsView);
      
    } else if (index == 1) {
      Get.toNamed(AppRoutes.securityAndPrivacyView);
    } 
    // else if (index == 2) {
    //   Get.to(() => AdvanceSettingView());
    // }
     else if (index == 2) {
    } else if (index == 3) {
      Get.toNamed(AppRoutes.contactsView);
    } 
    // else if (index == 4) {
    //   Get.toNamed(AppRoutes.notificationSettingsView);
    // } 
    else if (index == 4) {
      Get.toNamed(AppRoutes.helpCenterScreen);
    
    } else if (index == 5) {
      Get.toNamed(AppRoutes.inviteFriend);
     
    } else if (index == 6) {
      Get.toNamed(AppRoutes.aboutlnbg);
     // Get.to(() => AboutLNBG());
    } else if (index == 7) {
      logout();
    } else {}
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
Get.offAllNamed(AppRoutes.walkThroughScreen);
    
  }


  void followUsTabsOnTap(index) {
    if (index == 0  ) {
      final Uri url = Uri.parse('https://twitter.com/lnbglondon');
      _launchURL(url);
    }
    else if(index==2){
   final Uri url = Uri.parse('https://discord.com/invite/nmZ5vRyyAg');
      _launchURL(url);
    }
    else if(index==4){
   final Uri url = Uri.parse('https://t.me/lnglondon');
      _launchURL(url);
    }

  }
    Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
