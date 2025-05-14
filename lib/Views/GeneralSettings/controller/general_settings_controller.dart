import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralSettingsController extends GetxController {
  var selectedCurrency = 'USD - United States Dollar'.obs;
  var selectedLanguage = 'English - US'.obs;
  var selectedSearchEngine = 'Google'.obs;
  RxBool isSwiched = false.obs;
  var items=['English - US'.tr, 'Spanish - ES'.tr, 'French - FR'.tr].obs;
  @override
  void onInit()async{
    print("come here");
    super.onInit();
    final prefs = await SharedPreferences.getInstance();
    var selectedLan= prefs.get('selected_language');
    if(selectedLan==null){
      selectedLanguage.value='English - US';
    }
   else if(selectedLan=='en_US'){
selectedLanguage.value='English - US';
    }
    else if(selectedLan=='es_ES'){
selectedLanguage.value='Espagnol - ES';
    }
    else{
selectedLanguage.value='Français - FR';
    }

  }
  // var selectedCurrencyType = 0.obs;
  // changeCurrencyType(index) {
  //   selectedCurrencyType.value = index;
  // }
}
