import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Controller/past_order_controller.dart';
import '../../Util/Constant/app_images.dart';

class ProcessingQuotation extends GetView<PastOrderController> {
  const ProcessingQuotation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.creatingLoading.value) {
          return Container(
            color: Colors.white,
            // Semi-transparent overlay
            child: Center(
              child: Lottie.asset(
                AppImages.processingLottie,
                width: 200,
                height: 200,
              ),
            ),
          );
        }
        return SizedBox.shrink(); // Hide when not loading
      }),
    );
  }
}
