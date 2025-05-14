import 'package:get/get.dart';

class AdvanceSettingCntroller extends GetxController {
  RxBool gasControl = false.obs;
  RxBool tokenDetection = false.obs;
  RxBool dismiss = false.obs;
  RxBool syncData = false.obs;
  RxBool haxData = false.obs;
  RxBool transaction = false.obs;
  var selectedLegerConType = 'WebHID'.tr.obs;
}
