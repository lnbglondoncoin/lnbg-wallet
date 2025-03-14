import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveCoinController extends GetxController {
  var amountController = TextEditingController();


  void copyAddress(String walletAddress) {
    Clipboard.setData(ClipboardData(text: walletAddress));
    Get.snackbar("Copied", "Wallet address copied to clipboard");
  }

  // void shareQRCode(String walletAdddress) async {
  //   try {
  //     final qrImage = await _captureQRImage(walletAdddress);
  //     if (qrImage != null) {
  //       await Share.shareXFiles([XFile(qrImage.path)], text: 'Scan this QR code!');
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to share QR code");
  //   }
  // }

  // Future<File?> _captureQRImage(String walletAddress) async {
  //   try {
  //     final qrPainter = QrPainter(
  //       data: walletAddress,
  //       version: QrVersions.auto,
  //       gapless: false,
  //     );

  //     final tempDir = await getTemporaryDirectory();
  //     final qrFile = File('${tempDir.path}/qr_code.png');

  //     final image = await qrPainter.toImageData(300);
  //     await qrFile.writeAsBytes(image!.buffer.asUint8List());

  //     return qrFile;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
