import 'package:flutter_contacts_service/flutter_contacts_service.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/contact_model.dart';
import 'package:permission_handler/permission_handler.dart';


class ContactController extends GetxController {
  var contacts = <ContactInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }
var isLoading=false.obs;
  Future<void> fetchContacts() async {
    isLoading.value = true; // Start loading
    if (await Permission.contacts.request().isGranted) {
      try {
        final fetchedContacts = await FlutterContactsService.getContacts();
        contacts.value = fetchedContacts.toList();
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch contacts");
      }
    } else {
      Get.snackbar("Permission Denied", "Cannot access contacts");
    }
    isLoading.value = false; // Stop loading
  }
}
