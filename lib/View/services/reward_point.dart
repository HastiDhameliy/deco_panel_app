import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/feedback_controller.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';

class RewardPoint extends GetView<FeedbackController> {
  const RewardPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.4),
        flexibleSpace: Container(
            decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow color
              blurRadius: 10.0, // Soften the shadow
              offset: const Offset(0, 4), // Shadow appears below the AppBar
            ),
          ],
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Reward Point",
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSize.displayHeight(context) * 0.02,
            horizontal: AppSize.displayWidth(context) * 0.04),
        child: Center(
          child: Text(
            "Coming10 Soon",
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(
              color: AppColors.buttonColor,
              fontSize: Get.height / 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
