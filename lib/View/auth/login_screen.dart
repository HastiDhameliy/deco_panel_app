import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/custom/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/login_controller.dart';
import '../../Controller/otp_controller.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_images.dart';
import '../../Util/Constant/app_size.dart';
import '../../widget/common_button.dart';
import '../../widget/radio_button.dart';
import '../../widget/text_form_field_widget.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.only(
                left: Get.width / 25,
                right: Get.width / 25,
                top: Get.height / 18),
            child: Form(
              key: controller.loginStoreFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Let’s Verify Your Number",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 23,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color449,
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  Image.asset(
                    AppImages.loginVerification,
                    height: AppSize.displayHeight(context) * 0.3,
                  ),
                  SizedBox(
                    height: Get.height / 50,
                  ),
                  Text(
                    "Please enter your mobile number to \nreceive a verification code.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 50,
                      fontWeight: FontWeight.normal,
                      color: AppColors.colorA1E,
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  CommonTextField(
                    controller: controller.numberController.value,
                    hintText: "Enter your mobile number",
                    keyboardType: TextInputType.number,
                    // Set input type to number
                    validator: (val) {
                      if (val == null && val!.trim().isEmpty) {
                        return "Please Enter Number";
                      } else if (val.length != 10) {
                        return "Please Enter Valid Number";
                      }
                      return null;
                    },
                    maxLength: 10,
                    onChanged: (p0) {
                      controller.isAbleFun();
                    },
                    prefixIcon: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "    +91 |   ",
                          style: GoogleFonts.poppins(
                            fontSize: Get.height / 55,
                            fontWeight: FontWeight.w400,
                            color: AppColors.colorF91,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 25,
                  ),
                  RadioButtonWithSplash(
                    isSelected: controller.isAccepted.value,
                    onChanged: (bool value) {
                      controller.isAccepted.value = value;
                      controller.isAbleFun();
                    },
                    label: 'I accept the terms and privacy policy',
                    onTermsTap: () {},
                    onPrivacyPolicyTap: () {},
                  ),
                  SizedBox(
                    height: Get.height / 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(
                        () => CommonButton(
                          width: AppSize.displayWidth(context) * 0.5,
                          text: 'Get the code',
                          isEnabled: controller.isAble.value,
                          isLoading: controller.isLoading.value,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (controller.loginStoreFormKey.currentState!
                                .validate()) {
                              await ApiService()
                                  .mobileApi(
                                      phone: controller
                                          .numberController.value.text,
                                      context: context,
                                      loading: controller.isLoading)
                                  .then(
                                (value) async {
                                  if (value['code'] == 200) {
                                    /*mobileNumberController.password.value =
                                          value['data'];*/
                                    // await mobileNumberController.auth
                                    //     .setSettings(appVerificationDisabledForTesting: false);
                                    await FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                      forceResendingToken: 4,
                                      phoneNumber:
                                          "+91${controller.numberController.value.value.text.trim()}",
                                      timeout: const Duration(seconds: 60),
                                      verificationCompleted:
                                          (PhoneAuthCredential
                                              credential) async {
                                        //     mobileNumberController.isButtonLoading.value =
                                        // false;
                                        controller.auth
                                            .signInWithCredential(credential);
                                      },
                                      verificationFailed:
                                          (FirebaseAuthException e) async {
                                        print(
                                            'fError : ${e.code},${e.message}');
                                        if (e.code == 'invalid-phone-number') {
                                          // mobileNumberController.isButtonLoading.value =
                                          // false;
                                          customToast(
                                              context,
                                              "The provided phone number is not valid.",
                                              ToastType.warning);
                                          print(
                                              'The provided phone number is not valid.');
                                        } else if (e.code ==
                                            'too-many-requests') {
                                          // mobileNumberController.isButtonLoading.value =
                                          // false;
                                          customToast(
                                              context,
                                              "Sorry, You are many requested\nPlease try again later...",
                                              ToastType.warning);
                                        } else if (e.code == 'unknown') {
                                          // await otpController
                                          //     .postCheckMobileApi({
                                          //   "mobile": mobileNumberController
                                          //       .mobileNumberController
                                          //       .value
                                          //       .text
                                          //       .trim(),
                                          // });
                                          // mobileNumberController.isButtonLoading.value =
                                          // false;
                                          customToast(
                                              context,
                                              "Sorry, Internal error has occurred\nPlease try again later...",
                                              ToastType.error);
                                        } else {
                                          // mobileNumberController.isButtonLoading.value =
                                          // false;
                                          customToast(
                                              context,
                                              "Sorry, Something want wrong\nPlease try again later...",
                                              ToastType.warning);
                                        }
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        OtpController otpController =
                                            Get.put(OtpController());
                                        otpController.resendToken.value =
                                            resendToken ?? 0;
                                        otpController.verify.value =
                                            verificationId;
                                        customToast(
                                            context,
                                            "OTP Sent Successfully",
                                            ToastType.success);
                                        Get.offAllNamed(
                                            RouteConstants.otpScreen,
                                            arguments: {
                                              "no": controller
                                                  .numberController.value.text
                                            });

                                        // mobileNumberController.isButtonLoading.value =
                                        // false;
                                        // Get.to(() => OtpScreen(
                                        //   // verify: verificationId,
                                        //   // phoneNumber: controller
                                        //   //     .mobileNumberController
                                        //   //     .value
                                        //   //     .text
                                        //   //     .trim(),
                                        // ));
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {
                                        //     mobileNumberController.isButtonLoading.value =
                                        // false;

                                        // ShowToast.showToast(
                                        //   "The provided phone number is not valid.",
                                        //   showSuccess: false,
                                        // );
                                      },
                                    );
                                  } else {
                                    /* Get.to(() => SignNameScreen(
                                            phoneNumber: mobileNumberController
                                                .mobileNumberController
                                                .value
                                                .text
                                                .trim(),
                                          ));*/
                                  }
                                },
                              ).catchError(
                                (error) {
                                  customToast(context, error.toString(),
                                      ToastType.warning);
                                },
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 55,
                          fontWeight: FontWeight.normal,
                          color: AppColors.color449,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed(RouteConstants.editProfileScreen);
                        },
                        child: Text(
                          " Register",
                          style: GoogleFonts.ptSans(
                            fontSize: Get.height / 55,
                            fontWeight: FontWeight.w500,
                            color: AppColors.colorF45,
                          ),
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
