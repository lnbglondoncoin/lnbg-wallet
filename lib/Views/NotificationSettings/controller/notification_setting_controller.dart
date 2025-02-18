import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  List<String> tabs = [
    "General Notification",
    "Sound",
    "Vibrate",
    "Price Alerts",
    "Sent & Receive",
    "Product Announcements",
    "App Updates",
    "New Services Available",
    "New Tips Available"
  ];

  // Create a list of RxBool for each switch
  late List<RxBool> switchStates;

  @override
  void onInit() {
    super.onInit();
    switchStates = List.generate(tabs.length, (index) => true.obs);
  }
}
