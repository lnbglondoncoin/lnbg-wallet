import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lnbg_crypto_wallet_app/Constants/colors.dart';
import 'package:lnbg_crypto_wallet_app/Constants/images.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';

class CustomStepAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onBackTap;
  final RxInt currentIndex; // Pass current index as an RxInt
  final Function() onWillPop; // Function to handle WillPopScope logic
  const CustomStepAppBar({
    super.key,
    required this.onBackTap,
    required this.currentIndex,
    required this.onWillPop,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return WillPopScope(
      onWillPop: () async {
        onWillPop(); // Call the controller's function here
        return true; // Returning true allows the pop to happen
      },
      child: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        shadowColor: isDarkMode ? lightBlackColor3 : whiteColor,
        foregroundColor: isDarkMode ? lightBlackColor3 : whiteColor,
        surfaceTintColor: isDarkMode ? lightBlackColor3 : whiteColor,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: GestureDetector(
            onTap: onBackTap, // Call the provided function here
            child: SizedBox(
              height: 28.h,
              width: 28.w,
              child: Center(
                  child: SvgPicture.asset(
                arrowLeft,
                colorFilter: ColorFilter.mode(
                    isDarkMode ? whiteColor : blackColor2, BlendMode.srcIn),
              )),
            ),
          ),
        ),
        title: SizedBox(
          width: Get.width / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => buildStep(0, context)),
              Obx(() => buildLine(1, context)),
              Obx(() => buildStep(1, context)),
              Obx(() => buildLine(2, context)),
              Obx(() => buildStep(2, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStep(int index, BuildContext context) {
    final StepController controller = Get.find();
    bool isActive = controller.currentIndex.value >= index;
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: isActive
            ? LinearGradient(
                colors: [
                  isDarkMode
                      ? const Color(0xFFFFAB38)
                      : const Color(0xFFFFE580),
                  isDarkMode
                      ? const Color(0xFFFB9400)
                      : const Color(0xFFFACC15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isActive
            ? null
            : isDarkMode
                ? lightBlackColor
                : greyColor, // Default color for inactive steps
      ),
    );
  }

  Widget buildLine(int index, BuildContext context) {
    final StepController controller = Get.find();
    bool isActive = controller.currentIndex.value >= index;
    var theme = Theme.of(context);
    bool isDarkMode =
        theme.brightness == Brightness.dark; // Check if dark mode is active

    return Expanded(
      child: Container(
        height: 4.h,
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [primaryColor, lightPrimaryColor],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isActive
              ? null
              : isDarkMode
                  ? lightBlackColor
                  : greyColor, // Default color for inactive lines
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
