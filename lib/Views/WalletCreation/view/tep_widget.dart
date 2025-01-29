import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lnbg_crypto_wallet_app/Views/WalletCreation/controller/wallet_controller.dart';

class StepProgressIndicator extends StatelessWidget {
  final StepController controller = Get.put(StepController());

  StepProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => buildStep(0)), // Wrap individual widgets
            Obx(() => buildLine(1)),
            Obx(() => buildStep(1)),
            Obx(() => buildLine(2)),
            Obx(() => buildStep(2)),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (controller.currentIndex.value > 0) {
                  controller.updateIndex(controller.currentIndex.value - 1);
                }
              },
              child: const Text("Previous"),
            ),
            SizedBox(width: 10.w),
            ElevatedButton(
              onPressed: () {
                if (controller.currentIndex.value < 2) {
                  controller.updateIndex(controller.currentIndex.value + 1);
                }
              },
              child: const Text("Next"),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStep(int index) {
    final StepController controller = Get.find();
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.currentIndex.value >= index
            ? Colors.yellow
            : Colors.grey.shade300,
      ),
    );
  }

  Widget buildLine(int index) {
    final StepController controller = Get.find();
    return Expanded(
      child: Container(
        height: 4.h,
        color: controller.currentIndex.value >= index
            ? Colors.yellow
            : Colors.grey.shade300,
      ),
    );
  }
}
