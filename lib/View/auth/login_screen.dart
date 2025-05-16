import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/custom/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Controller/login_controller.dart';
import '../../Controller/otp_controller.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';
import '../../widget/common_button.dart';
import '../../widget/radio_button.dart';
import '../../widget/text_form_field_widget.dart';

OtpController otpController = Get.put(OtpController());

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final webcontroller = WebViewController();

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
                    "Welcome to",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color449,
                    ),
                  ),
                  Text(
                    "Deco Panel",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color449,
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  Image.asset(
                    "assets/dp_png.png",
                    height: AppSize.displayHeight(context) * 0.23,
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
                    label: 'I accept the terms and condition',
                    onTermsTap: () async {
                      webcontroller
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse(
                            "https://decopanel.in/privacypolicy.html"));
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            titlePadding:
                                EdgeInsets.only(top: 10, right: 10, bottom: 0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.textBlack
                                              .withOpacity(0.2)
                                              .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.textBlack,
                                      )),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(0),
                            content: Container(
                              width: 430, // Adjust the width here
                              child: WebViewWidget(controller: webcontroller),
                            ),
                          );
                        },
                      );
                      // Get.to(TermsAndConditionPage(url: ConstantString.loginTermsUrl,),);
                    },
                    onPrivacyPolicyTap: () async {
                      webcontroller
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse(
                            "https://decopanel.in/privacypolicy.html"));
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            titlePadding:
                                EdgeInsets.only(top: 10, right: 10, bottom: 0),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.textBlack
                                              .withOpacity(0.2)
                                              .withOpacity(0.5)),
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.textBlack,
                                      )),
                                ),
                              ],
                            ),
                            contentPadding: EdgeInsets.all(0),
                            content: Container(
                              width: 430, // Adjust the width here
                              child: WebViewWidget(controller: webcontroller),
                            ),
                          );
                        },
                      );
                      // Get.to(TermsAndConditionPage(url: ConstantString.loginTermsUrl,),);
                    },
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
                              try {
                                controller.isLoading.value = true;

                                // Call your API
                                final value = await ApiService().mobileApi(
                                  phone: controller.numberController.value.text
                                      .trim(),
                                  context: context,
                                  loading: controller.isLoading,
                                );

                                if (value['code'] == 200) {
                                  //Get.offAllNamed(RouteConstants.otpScreen,
                                  //    arguments: {
                                  //      "no": controller
                                  //          .numberController.value.text,
                                  //    });
                                  //otpController.isLoading.value = false;
                                  await FirebaseAuth.instance.setSettings(
                                    appVerificationDisabledForTesting:
                                        false, // Ensure this is false for production
                                  );
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber:
                                        "+91${controller.numberController.value.text.trim()}",
                                    timeout: const Duration(seconds: 60),
                                    forceResendingToken: 4,
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) async {
                                      await controller.auth
                                          .signInWithCredential(credential);
                                    },
                                    verificationFailed:
                                        (FirebaseAuthException e) async {
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
                                      controller.isLoading.value =
                                          false; // Stop the loader here
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      otpController.resendToken.value =
                                          resendToken ?? 0;
                                      otpController.verify.value =
                                          verificationId;
                                      print("Verify :$verificationId");
                                      print(
                                          "Verify :${otpController.verify.value}");
                                      otpController.update();

                                      customToast(
                                        context,
                                        "OTP Sent Successfully",
                                        ToastType.success,
                                      );
                                      controller.isLoading.value = false;
                                      Get.offAllNamed(RouteConstants.otpScreen,
                                          arguments: {
                                            "no": controller
                                                .numberController.value.text,
                                          });
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {
                                      customToast(
                                        context,
                                        "OTP auto-retrieval timeout.",
                                        ToastType.warning,
                                      );
                                    },
                                  );
                                } else {
                                  customToast(
                                    context,
                                    "Failed to send the OTP. Please try again.",
                                    ToastType.error,
                                  );
                                }
                                controller.isLoading.value = false;
                              } catch (error) {
                                customToast(
                                  context,
                                  "Error: ${error.toString()}",
                                  ToastType.error,
                                );
                                controller.isLoading.value = false;
                              } finally {
                                controller.isLoading.value = false;
                              }
                            }
                          },
                        ),
                      ),
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
                          " Sign up",
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
