import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/login_controller.dart';
import '../../Data/Services/api_service.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/custom/custom_toast.dart';
import '../../widget/common_button.dart';
import '../../widget/text_form_field_widget.dart';
import 'login_screen.dart';

class EditProfileScreen extends GetView<LoginController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.profileFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: AppSize.displayHeight(context) * 0.02,
              horizontal: AppSize.displayWidth(context) * 0.03),
          children: [
            SizedBox(
              height: Get.height / 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.offAllNamed(RouteConstants.loginScreen);
                  },
                  child: Text(
                    " Login",
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorF45,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height / 60,
            ),
            Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: GoogleFonts.ptSans(
                fontSize: Get.height / 23,
                fontWeight: FontWeight.w700,
                color: AppColors.color449,
              ),
            ),
            Text(
              "Create your account",
              textAlign: TextAlign.center,
              style: GoogleFonts.abhayaLibre(
                fontSize: Get.height / 55,
                fontWeight: FontWeight.w300,
                color: AppColors.color449,
              ),
            ),
            SizedBox(
              height: Get.height / 55,
            ),
            CustomRoundedTextField(
              labelText: "Name",
              controller: controller.nameCon.value,
              textInputAction: TextInputAction.next,
              onChanged: (p0) {
                controller.isAbleFun2();
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
                controller.isAbleFun2();
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
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (p0) {
                controller.isAbleFun2();
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
                controller.isAbleFun2();
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
                controller.isAbleFun2();
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.045),
            CustomRoundedTextField(
              labelText: "Image",
              controller: controller.imageCon.value,
              readOnly: true,
              suffixIcon: PopupMenuButton<ImageSource>(
                onSelected: (source) {
                  controller.pickImage(source);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    AppImages.imageIcon,
                    height: AppSize.displayHeight(context) * 0.04,
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: ImageSource.camera,
                    child: Row(
                      children: const [
                        Icon(Icons.camera_alt, size: 20),
                        SizedBox(width: 10),
                        Text("Camera"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: ImageSource.gallery,
                    child: Row(
                      children: [
                        Icon(Icons.photo_library, size: 20),
                        SizedBox(width: 10),
                        Text("Gallery"),
                      ],
                    ),
                  ),
                ],
              ),
              onChanged: (val) {
                controller.isAbleFun2();
              },
            ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => CommonButton(
                    width: AppSize.displayWidth(context) * 0.6,
                    text: 'Save & Next',
                    isEnabled: controller.isAble2.value,
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (controller.profileFormKey.currentState!.validate()) {
                        await ApiService()
                            .updateUserApiUrl(
                          context: context,
                          profilePhoto: controller.selectedImage.value.path,
                          mobile: controller.mobileCon.value.text,
                          area: controller.areaCon.value.text,
                          loading: controller.isLoading,
                          name: controller.nameCon.value.text,
                          email: controller.emailCon.value.text,
                          address: controller.addressCon.value.text,
                        )
                            .then(
                          (value) async {
                            if (value['code'] == 200) {
                              await FirebaseAuth.instance.setSettings(
                                appVerificationDisabledForTesting:
                                    false, // Ensure this is false for production
                              );

                              await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber:
                                    "+91${controller.mobileCon.value.text.trim()}",
                                timeout: const Duration(seconds: 60),
                                forceResendingToken: 4,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  await controller.auth
                                      .signInWithCredential(credential);
                                },
                                verificationFailed:
                                    (FirebaseAuthException e) async {
                                  controller.isLoading.value = false;
                                  switch (e.code) {
                                    case 'invalid-phone-number':
                                      customToast(
                                        context,
                                        "The provided phone number is not valid.",
                                        ToastType.warning,
                                      );
                                      break;
                                    case 'too-many-requests':
                                      customToast(
                                        context,
                                        "Too many requests. Please try again later.",
                                        ToastType.warning,
                                      );
                                      break;
                                    default:
                                      customToast(
                                        context,
                                        "Error: ${e.message ?? "Something went wrong"}",
                                        ToastType.error,
                                      );
                                  }
                                },
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  otpController.resendToken.value =
                                      resendToken ?? 0;
                                  otpController.verify.value = verificationId;

                                  customToast(
                                    context,
                                    "OTP Sent Successfully",
                                    ToastType.success,
                                  );

                                  Get.offAllNamed(RouteConstants.otpScreen,
                                      arguments: {
                                        "no": controller.mobileCon.value.text,
                                      });
                                  controller.isLoading.value =
                                      false; // Stop the loader
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {
                                  customToast(
                                    context,
                                    "OTP auto-retrieval timeout.",
                                    ToastType.warning,
                                  );
                                  controller.isLoading.value =
                                      false; // Stop the loader
                                },
                              );
                            } else {
                              customToast(
                                context,
                                "Failed to send the OTP. Please try again.",
                                ToastType.error,
                              );
                              controller.isLoading.value =
                                  false; // Stop the loader
                            }
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
