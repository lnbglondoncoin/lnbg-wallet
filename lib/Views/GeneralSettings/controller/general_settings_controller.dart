import 'package:get/get.dart';

class GeneralSettingsController extends GetxController {
  var selectedCurrency = 'USD - United States Dollar'.obs;
  var selectedLanguage = 'English - US'.obs;
  var selectedSearchEngine = 'Google'.obs;
  RxBool isSwiched = false.obs;
  var selectedCurrencyType = 0.obs;
  changeCurrencyType(index) {
    selectedCurrencyType.value = index;
  }
}
