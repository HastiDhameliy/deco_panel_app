import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/otp_controller.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_images.dart';
import '../../widget/common_button.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() => Container(
              padding: EdgeInsets.only(
                  left: Get.width / 25,
                  right: Get.width / 25,
                  top: Get.height / 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      "Enter Verification \nCode",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ptSans(
                        fontSize: Get.height / 23,
                        fontWeight: FontWeight.w700,
                        color: AppColors.color449,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  Image.asset(
                    AppImages.loginVerify,
                    // Width of each input field
                    height: AppSize.displayHeight(context) * 0.3,
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.04,
                  ),
                  Text(
                    "Please enter verification code \nsent to +91 ${Get.arguments != null && Get.arguments["no"] != null ? Get.arguments["no"] : ""}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 50,
                      fontWeight: FontWeight.normal,
                      color: AppColors.colorA1E,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.05,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      controller: controller.otpController.value,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      followingPinTheme: PinTheme(
                        width: AppSize.displayWidth(context) * 0.14,
                        // Width of each input field
                        height: AppSize.displayWidth(context) * 0.14,
                        // Height of each input field
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        // Customize text style

                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.colorADB,
                              width: 1), // Border color
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Round corners for input fields
                        ),
                      ),
                      disabledPinTheme: PinTheme(
                        width: AppSize.displayWidth(context) * 0.14,
                        // Width of each input field
                        height: AppSize.displayWidth(context) * 0.14,
                        // Height of each input field
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        // Customize text style

                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.buttonColor,
                              width: 1), // Border color
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Round corners for input fields
                        ),
                      ),
                      onCompleted: (String verificationCode) {
                        // debugPrint('onCompleted: $pin');
                      },
                      onChanged: (code) {
                        controller.isAbleFun();

                        // debugPrint('onChanged: $value');
                      },
                      focusedPinTheme: PinTheme(
                        width: AppSize.displayWidth(context) * 0.14,
                        // Width of each input field
                        height: AppSize.displayWidth(context) * 0.14,
                        // Height of each input field
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        // Customize text style

                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.buttonColor,
                              width: 1), // Border color
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Round corners for input fields
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        width: AppSize.displayWidth(context) * 0.14,
                        // Width of each input field
                        height: AppSize.displayWidth(context) * 0.14,
                        // Height of each input field
                        textStyle:
                            const TextStyle(fontSize: 20, color: Colors.black),
                        // Customize text style

                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.buttonColor,
                              width: 1), // Border color
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Round corners for input fields
                        ),
                      ),
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 1,
                            height: 22,
                            color: AppColors.colorA1E,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 50,
                          fontWeight: FontWeight.normal,
                          color: AppColors.color449,
                        ),
                      ),
                      Text(
                        " Resend",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 50,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorF45,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => CommonButton(
                          width: AppSize.displayWidth(context) * 0.5,
                          text: 'Verify the Code',
                          isLoading: controller.isLoading.value,
                          isEnabled: controller.isAble.value,
                          onPressed: () {
                            ApiService().loginApi(
                                phone: Get.arguments != null &&
                                        Get.arguments["no"] != null
                                    ? Get.arguments["no"]
                                    : "",
                                context: context,
                                loading: controller.isLoading);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
