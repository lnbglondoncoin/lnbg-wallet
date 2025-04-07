import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/contact_model.dart';

class InviteFriendController extends GetxController {
  var selectedIndices = <int>{}.obs;

  List<ContactModel> contacts = [
    ContactModel(
        name: "Maryland Winkles",
        id: "0x9ECB6773702CAD6F3382A3596FFCEA",
        imageUrl: "assets/images/contact1.png"),
    ContactModel(
        name: "John Doe",
        id: "0x1234567890ABCDEF1234567890ABCDEF",
        imageUrl: "assets/images/contact2.png"),
    ContactModel(
        name: "Jane Smith",
        id: "0x9876543210FEDCBA9876543210FEDCBA",
        imageUrl: "assets/images/contact3.png"),
  ].obs;

  void toggleContact(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }
}
