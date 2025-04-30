import 'package:get/get.dart';

class HelpCenterController extends GetxController {
  var selectedTab = 0.obs;
  var expandedIndex = (-1).obs;
  List<String> tabs = ['General', 'Account', 'Service', 'Application'];

  List<Map<String, String>> faqs = [
    {
      'question': 'What is LNBG Coin?',
      'answer':
          'LNBG London Coin is a cryptocurrency developed by a UK-based team, combining elements of traditional finance with decentralized finance (DeFi) innovations.'
    },
    {
      'question': 'How to send cryptocurrency?',
      'answer': 'You can see list of coins on homescreen, click any coin you want to send and you can see send option there, click on send option, 1).add recipient wallet address and ammount that you want to send, 2).click continue and click send button ,otherwise you can also click on send button on home screen and repeat step 1 and 2.'
    },
    {
      'question': 'How to receive cryptocurrency?',
      'answer': "You can see list of coins on homescreen, click any coin you want to receive and you can see receive option there, click on receive option and 1). QR code will appear if you will click on share button below Qr Code of your wallet address ,it will take you to the options through which you can share QR code to anyone and request to send you crypto,otherwise if you click on copy button then your wallet address will be copied on yur clipboard you can paste in anyone's chat to send him and request crypto, otherwise you can also click on receive button on home screen and repeat step 1.",
    },
    {
      'question': 'How can I buy cryptocurrency?',
      'answer': 'You can see list of coins on homescreen, click any coin you want to buy and you can see buy option there, click on buy option, 1). enter ammount in dolors for which you want to buy crypto and click on continue ,2) Moonpay will open and you can buy from there.otherwise you can also click on buy button on home screen and repeat step 1 and 2.'
    },
     {
      'question': 'How to swap cryptocurrency?',
      'answer': 'You can see list of coins on homescreen, click any coin you want to swap and you can see swap option there, click on swap option, 1)Select the first coin you want to swap from   2).Select the second coin you want to swap to ,3) Enter balance of first coin in dolors that you want to swap or you can also click the tabs belo like 25%, 50%, 75% and 100% it will automatically check availabe balance of first coin and fill the selected percentage of that balance in balance feild ,4).Click on swap button  and it will take you to next screen where you can see the details,5) click on confirm button and wait ,you coin will be swaped,   ,otherwise you can also click on swap button on home screen and repeat step 1,2,3,4 and 5.'
    },
    {
      'question': 'How do I exit the app?',
      'answer': 'You can simply press the home button on your device or swipe up from the bottom of screen to exit the app.'
    },
    {
      'question': 'How can I deactivate my account?',
      'answer': 'Open settings tab , then open security and privacy section, scroll on the bottom and you will see delete account option ,just click delete wallet and your wallet will be deleted , remember you can always recover it from seed phrase.'
    },
  ];
}
