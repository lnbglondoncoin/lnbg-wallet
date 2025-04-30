import 'package:get/get.dart';
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

class SettingsController extends GetxController {
  List settingIcons = [
   // "assets/icons/wallets.png",
    "assets/icons/general.png",
    "assets/icons/security.png",
   // "assets/icons/advance.png",
    "assets/icons/darkMode.png",
    "assets/icons/contacts.png",
    "assets/icons/notifications5.png",
    "assets/icons/helpc.png",
    "assets/icons/invite.png",
    "assets/icons/about.png",
    "assets/icons/about.png", //logout
  ];

  List settingLabels = [
   // "Wallets",
    "Language",
    "Security & Privacy",
   // "Advanced",
    "Dark Mode",
    "Contacts",
    "Notification",
    "Help Center",
    "Invite Friends",
    "About LNBG Wallet",
    "Logout",
  ];

  settingActions(index) {
    // if (index == 0) {
    //   Get.to(() => WalletScreen());
    // } 
     if (index == 0) {
      Get.to(() => GenralSettingsView());
    } else if (index == 1) {
      Get.to(() => SecurityAndPrivacyView());
    } 
    // else if (index == 2) {
    //   Get.to(() => AdvanceSettingView());
    // }
     else if (index == 2) {
    } else if (index == 3) {
      Get.to(() => ContactsView());
    } else if (index == 4) {
      Get.to(() => NotificationSettingsView());
    } else if (index == 5) {
      Get.to(() => HelpCenterScreen());
    } else if (index == 6) {
      Get.to(() => InviteFriend());
    } else if (index == 7) {
      Get.to(() => AboutLNBG());
    } else if (index == 8) {
      logout();
    } else {}
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAll(() => WalkThroughScreen());
  }
}
