import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Views/NFT/controller/nft_controller.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/Services/wallet_address_service.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_app_bar.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_button.dart';
import 'package:lnbg_crypto_wallet_app/Widgets/custom_textfeild.dart';
import 'package:shimmer/shimmer.dart';

class ImportNFTScreen extends StatelessWidget {
   ImportNFTScreen({super.key});
   final walletCreatingController = Get.find<WalletCreatingController>();
final nftController = Get.put(NftController());
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Scaffold(
      backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
      appBar: const CustomAppBar(title: "Import NFT", iconPath: ""),
      body: SingleChildScrollView(
        child: Obx((){
          return 
          nftController.isLoading.value? _buildImportNFTShimmer(isDarkMode):
          Padding(
          padding: EdgeInsets.all(20.h),
          child: Form(
            key: nftController.importNftKey,
            child: Column(
              children: [
                CustomTextField(
                    hintText: "0x7131CA84856767f3126a2C75468d48f8E696",
                    controller: nftController.adressController,
                    labelText: "Address",
                     validator: (value) {
                            if (value == null || value.isEmpty) {
                  return 'Address is required';
                } else if (!RegExp(r'^0x[a-fA-F0-9]{40}$').hasMatch(value)) {
                  return "Invalid contract address format";
                }
                            return null;
                          },),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                    hintText: "Enter the Collectible ID",
                    controller: nftController.idController,
                    labelText: "ID",
                      validator: (value) {
                            if (value == null || value.isEmpty) {
                  return 'ID is required';
                }
                 if (!RegExp(r'^\d+$').hasMatch(value)) {
                  return 'ID must be a number';
                }
                            return null;
                          },)
              ],
            ),
          ),
        );
        })   ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx((){
        return nftController.isLoading.value?_buildImportActionShimmer(isDarkMode):
        Container(
        decoration: BoxDecoration(
            color: isDarkMode ? lightBlackColor3 : whiteColor,
            border: Border(
                top: BorderSide(
                    color: isDarkMode ? lightBlackColor : greyColor4))),
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Row(
            children: [
              Flexible(
                  child: CustomLightGreenButton(
                      buttonText: "Cancel", onPressed: () {
                        Get.back();
                      })),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                  child: CustomButton(buttonText: "Import", onPressed: () {
                      if (nftController.importNftKey.currentState!.validate()) {
        nftController.importNFT(
          walletAddress: walletCreatingController.wallwtAddress.value,
          nftAddress: nftController.adressController.text,
          collectibleId: nftController.idController.text,
        );
      }
                  }))
            ],
          ),
        ),
      );
      })  );
  }
Widget _buildImportActionShimmer(bool isDarkMode) {
  return Container(
    decoration: BoxDecoration(
      color: isDarkMode ? lightBlackColor3 : whiteColor,
      border: Border(
        top: BorderSide(
          color: isDarkMode ? lightBlackColor : greyColor4,
        ),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(20.h),
      child: Row(
        children: [
          // Cancel Button Shimmer
          Expanded(
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Import Button Shimmer
          Expanded(
            child: Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildImportNFTShimmer(bool isDarkMode) {
  return Shimmer.fromColors(
    baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
    highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Address Field Shimmer
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 20.h),
          // ID Field Shimmer
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(height: 20.h),
          // Row of Two Fields Shimmer
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          // Import Button Shimmer
          Container(
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ],
      ),
    ),
  );
}

}
