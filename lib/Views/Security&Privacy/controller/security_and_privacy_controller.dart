import 'package:get/get.dart';

class SecurityAndPrivacyController extends GetxController {
  var selectedlocTime = 'After 5 minutes'.obs;
  RxBool isBiometric = false.obs;
  RxBool isface = false.obs;
  RxBool isRemember = false.obs;
  RxBool isPrivacy = false.obs;
  RxBool isAutoDectNFT = false.obs;
  RxBool openSeaAPI = false.obs;
  RxBool phishingDetection = false.obs;
  RxBool incommingTransections = false.obs;
}
