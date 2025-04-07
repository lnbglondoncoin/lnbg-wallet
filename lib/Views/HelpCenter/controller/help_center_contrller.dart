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
      'answer': 'Step-by-step guide to send cryptocurrency.'
    },
    {
      'question': 'How to receive cryptocurrency?',
      'answer': 'Instructions on how to receive cryptocurrency.'
    },
    {
      'question': 'How can I buy cryptocurrency?',
      'answer': 'Guide for buying cryptocurrency securely.'
    },
    {
      'question': 'How do I exit the app?',
      'answer': 'Instructions on how to exit the app.'
    },
    {
      'question': 'How can I deactivate my account?',
      'answer': 'Steps to deactivate your account safely.'
    },
  ];
}
