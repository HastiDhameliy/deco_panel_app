import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/profile_controller.dart';
import '../../Data/Services/api_service.dart';
import '../../Util/Constant/app_colors.dart';
import '../../widget/common_button.dart';
import '../../widget/text_form_field_widget.dart';

final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

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
                color: Colors.black.withOpacity(0.1),
                // Light shadow color
                blurRadius: 10.0,
                // Soften the shadow
                offset: const Offset(0, 4), // Shadow appears below the AppBar
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              AppImages.homeIcon,
              height: AppSize.displayHeight(context) * 0.027,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.ptSans(
            fontSize: Get.height / 40,
            fontWeight: FontWeight.w700,
            color: AppColors.color333,
          ),
        ),
      ),
      body: Form(
        key: profileFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: AppSize.displayHeight(context) * 0.02,
              horizontal: AppSize.displayWidth(context) * 0.03),
          children: [
            CustomRoundedTextField(
              labelText: "Name",
              controller: controller.nameCon.value,
              textInputAction: TextInputAction.next,
              onChanged: (p0) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ).paddingOnly(
                bottom: AppSize.displayHeight(context) * 0.045,
                top: AppSize.displayHeight(context) * 0.03),
            CustomRoundedTextField(
              labelText: "Mobile",
              controller: controller.mobileCon.value,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLength: 10,
              onChanged: (p0) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please enter your number";
                } else if (value.length != 10) {
                  return "Please enter valid number";
                }
                return null;
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.045),
            CustomRoundedTextField(
              labelText: "Email",
              controller: controller.emailCon.value,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onChanged: (p0) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please enter your number";
                }
                return null;
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.045),
            CustomRoundedTextField(
              labelText: "Area",
              controller: controller.areaCon.value,
              textInputAction: TextInputAction.next,
              onChanged: (p0) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please enter your area";
                }
                return null;
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.045),
            CustomRoundedTextField(
              labelText: "Address",
              controller: controller.addressCon.value,
              textInputAction: TextInputAction.done,
              onChanged: (p0) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please enter your address";
                }
                return null;
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.045),
            CustomRoundedTextField(
              labelText: "Image",
              controller: controller.imageCon.value,
              readOnly: true,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.pickImage(ImageSource.camera);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    AppImages.imageIcon,
                    height: AppSize.displayHeight(context) * 0.04,
                  ),
                ),
              ),
              onChanged: (val) {
                controller.isAbleFun();
              },
              validator: (value) {
                if (value == null && value!.trim().isEmpty) {
                  return "Please add your image";
                }
                return null;
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => CommonButton(
                    width: AppSize.displayWidth(context) * 0.6,
                    text: 'Save & Next',
                    isEnabled: controller.isAble.value,
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      if (profileFormKey.currentState!.validate()) {
                        await ApiService()
                            .updateUserApiUrl(
                                context: context,
                                area: controller.areaCon.value.text,
                                loading: controller.isLoading,
                                name: controller.nameCon.value.text,
                                email: controller.emailCon.value.text,
                                address: controller.addressCon.value.text,
                                state: userDetails.data?.user?.state ?? "",
                                pincode: userDetails.data?.user?.pincode ?? "")
                            .then(
                          (value) {
                            controller.getProfileData();
                            controller.clearAllController();
                            Get.back();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
