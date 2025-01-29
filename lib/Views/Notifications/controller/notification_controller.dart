import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  void fetchNotifications() {
    notifications.assignAll([
      NotificationModel(
        title: "Security Updates!",
        dateTime: "20 Dec, 2022 | 20:49 PM",
        description:
            "Now LNBG Wallet has a Two-Factor Authentication. Try it now to make your account more secure.",
        isNew: true,
        iconPath: "assets/icons/su.png",
      ),
      NotificationModel(
        title: "Multiple Wallet Features!",
        dateTime: "19 Dec, 2022 | 18:35 PM",
        description:
            "Now you can also connect LNBG Wallet with your other wallets. Try the service now.",
        isNew: true,
        iconPath: "assets/icons/mwf.png",
      ),
      NotificationModel(
        title: "LNBG Wallet Has Updates!",
        dateTime: "14 Dec, 2022 | 10:52 AM",
        description:
            "Now you can make multiple crypto transactions at once with low gas fees.",
        isNew: false,
        iconPath: "assets/icons/lwh.png",
      ),
      NotificationModel(
        title: "New Updates Available!",
        dateTime: "12 Dec, 2022 | 15:38 PM",
        description:
            "Update LNBG Wallet now to get access to the latest features, NFTs, & cryptocurrencies. ",
        isNew: false,
        iconPath: "assets/icons/nua.png",
      ),
    ]);
  }
}
