import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Models/contact_model.dart';

class ContactController extends GetxController{
  List<ContactModel> contacts=[
    ContactModel(name: "Maryland Winkles", id: "0x9ECB6773702CAD6F3382A3596FFCEA", imageUrl: "assets/images/contact1.png"),
       ContactModel(name: "Maryland Winkles", id: "0x9ECB6773702CAD6F3382A3596FFCEA", imageUrl: "assets/images/contact2.png"),
           ContactModel(name: "Maryland Winkles", id: "0x9ECB6773702CAD6F3382A3596FFCEA", imageUrl: "assets/images/contact3.png"),
  ].obs;
}