import 'package:deco_flutter_app/Controller/feedback_controller.dart';
import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Util/Constant/app_colors.dart';
import '../../widget/common_button.dart';
import '../../widget/text_form_field_widget.dart';

class FeedBackScreen extends GetView<FeedbackController> {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                  color: Colors.black.withOpacity(0.1),
                  // Light shadow color
                  blurRadius: 10.0,
                  // Soften the shadow
                  offset: const Offset(0, 4), // Shadow appears below the AppBar
                ),
              ],
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Feedback",
            style: GoogleFonts.roboto(
              color: AppColors.color333,
              fontSize: Get.height / 35,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.displayHeight(context) * 0.02,
                horizontal: AppSize.displayWidth(context) * 0.04),
            child: Form(
              key: controller.feedbackFormKey,
              child: ListView(
                children: [
                  SvgPicture.asset(
                    AppImages.feedbackBg,
                    height: AppSize.displayHeight(context) * 0.23,
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.01,
                  ),
                  CommonTextField(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.displayHeight(context) * 0.02),
                    ),
                    fillColor: Colors.white,
                    controller: controller.titleCon.value,
                    hintText: "Title",
                    keyboardType: TextInputType.text,
                    // Set input type to number
                    validator: (val) {
                      if (val == null && val!.trim().isEmpty) {
                        return 'Please enter title for feedback';
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      controller.isAbleFun();
                    },
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.02,
                  ),
                  CommonTextField(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.displayHeight(context) * 0.02),
                    ),
                    fillColor: Colors.white,
                    controller: controller.descriptionCon.value,
                    hintText: "Description",
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    // Set input type to number
                    validator: (val) {
                      if (val == null && val!.trim().isEmpty) {
                        return 'Please enter Description for feedback';
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      controller.isAbleFun();
                    },
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.04,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: 'Submit',
                          isEnabled: controller.isAble.value,
                          isLoading: controller.isLoading.value,
                          disabledColor: AppColors.buttonSplashColor,
                          onPressed: () async {
                            // Close the keyboard
                            FocusScope.of(context).unfocus();

                            if (controller.feedbackFormKey.currentState!
                                .validate()) {
                              await ApiService()
                                  .createFeedbackApi(
                                context: context,
                                loading: controller.isLoading,
                                sub: controller.titleCon.value.text,
                                des: controller.descriptionCon.value.text,
                              )
                                  .then(
                                (value) {
                                  if (value == true) {
                                    Get.back();
                                    Get.back();
                                  }
                                },
                              );
                              controller.titleCon.value.clear();
                              controller.descriptionCon.value.clear();
                              controller.isAbleFun();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
