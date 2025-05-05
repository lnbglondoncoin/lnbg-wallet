import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutLNBGController extends GetxController {
  List aboutTabs = [
    "Privacy Policy",
    "Terms of Services",
    "Attributions",
    "Support Center",
    "Rate us",
    "Visit Our Website",
    "Contact us"
  ];

  void aboutLnbgTabsOnTap(index) {
      if (index == 5) {
      final Uri url = Uri.parse('https://www.lnbglondon.com/en');
      _launchURL(url);
    }
    else if (index == 6) {
      final Uri url = Uri.parse('https://www.lnbglondon.com/en/contact');
      _launchURL(url);
    }
  }

  Future<void> _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
