import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/profile_controller.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_images.dart';
import '../../Util/Constant/app_size.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            SizedBox(
              height: AppSize.displayHeight(context) * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: AppSize.displayWidth(context) * 0.42,
                  width: AppSize.displayWidth(context) * 0.42,
                  padding: const EdgeInsets.all(defaultPadding / 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.buttonColor),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(defaultRadius * 50)),
                    child: Image.asset(
                      AppImages.panelImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                /*InkWell(
                onTap: () {
                  Get.to(const EditProfileScreen());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: AppColors.darkHintColor,
                      size: AppSize.displayHeight(context) * 0.03,
                    ),
                    SizedBox(
                      width: AppSize.displayWidth(context) * 0.02,
                    ),
                    Text(
                      "Edit",
                      style: GoogleFonts.roboto(
                          color: AppColors.darkHintColor,
                          fontSize: Get.height / 45,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),*/
              ],
            ),
            SizedBox(
              height: AppSize.displayHeight(context) * 0.02,
            ),
            commonProfileTextWidget(
              title: "Name:",
              subTitle: controller.useDataModel.value.data?.fullName ?? "",
              context: context,
            ),
            commonProfileTextWidget(
              title: "Mobile:",
              subTitle: controller.useDataModel.value.data?.mobile ?? "",
              context: context,
            ),
            commonProfileTextWidget(
              title: "Email:",
              subTitle: controller.useDataModel.value.data?.email ?? "",
              context: context,
            ),
            commonProfileTextWidget(
              title: "Area:",
              subTitle: controller.useDataModel.value.data?.state ?? "",
              context: context,
            ),
            commonProfileTextWidget(
              title: "Address:",
              subTitle: controller.useDataModel.value.data?.address ?? "",
              context: context,
            ),
            // SizedBox(
            //   height: AppSize.displayHeight(context) * 0.1,
            // ),
            const Divider(
              color: AppColors.buttonColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget commonProfileTextWidget(
      {String? title, String? subTitle, BuildContext? context}) {
    return Column(
      children: [
        const Divider(
          color: AppColors.buttonColor,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.displayWidth(context) * 0.09,
            ),
            Expanded(
              flex: 2,
              child: Text(
                title ?? "" " :",
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  color: AppColors.hintColor2,
                  fontSize: Get.height / 50,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              width: AppSize.displayWidth(context) * 0.06,
            ),
            Expanded(
              flex: 8,
              child: Text(
                subTitle ?? "",
                style: GoogleFonts.roboto(
                  color: AppColors.darkHintColor,
                  fontSize: Get.height / 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
