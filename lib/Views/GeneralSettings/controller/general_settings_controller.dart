import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GeneralSettingsController extends GetxController{
  var selectedCurrency = 'USD - United States Dollar'.obs;
  var selectedCurrencyType = 'Native'.obs;
  var selectedLanguage = 'English - US'.obs;
  var selectedSearchEngine = 'Google'.obs;
}