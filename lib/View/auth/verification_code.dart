import 'package:another_telephony/telephony.dart';
import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/View/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../Controller/login_controller.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_images.dart';
import '../../Util/custom/custom_toast.dart';
import '../../widget/common_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  LoginController loginController = Get.put(LoginController());

  // OtpController controller = Get.put(OtpController());
  int backspaceCount = 0;
  final telephony = Telephony.instance;
  RxBool checkTermsCondition = false.obs;

  //final controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    listenToIncomingSMS(context);
    super.initState();
  }

  void listenToIncomingSMS(BuildContext context) {
    print("Listening to sms.");
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) {
          // Handle message
          print("sms received : ${message.body}");
          // verify if we are reading the correct sms or not

          if (message.body!.contains("deco-panel.firebaseapp.com")) {
            String otpCode = message.body!.substring(0, 6);
            print("OTP::::::$otpCode");
            setState(
              () {
                otpController.otpController.value.text = otpCode;
              },
            );
          }
        },
        listenInBackground: false);
  }

  Future<void> sendOTP() async {
    await loginController.auth
        .setSettings(appVerificationDisabledForTesting: true);
    await FirebaseAuth.instance.verifyPhoneNumber(
      forceResendingToken: 4,
      phoneNumber: "+91${loginController.numberController.value.text.trim()}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        //     mobileNumberController.isButtonLoading.value =
        // false;
        await loginController.auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) async {
        print('fError : ${e.code},${e.message}');
        if (e.code == 'invalid-phone-number') {
          // mobileNumberController.isButtonLoading.value =
          // false;
          customToast(context, "The provided phone number is not valid.",
              ToastType.warning);

          print('The provided phone number is not valid.');
        } else if (e.code == 'too-many-requests') {
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
      codeSent: (String verificationId, int? resendToken) {
        otpController.resendToken.value = resendToken ?? 0;
        otpController.verify.value = verificationId;
        customToast(context, "OTP Sent Successfully", ToastType.success);
        listenToIncomingSMS(context);
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
      codeAutoRetrievalTimeout: (String verificationId) {
        //     mobileNumberController.isButtonLoading.value =
        // false;

        // ShowToast.showToast(
        //   "The provided phone number is not valid.",
        //   showSuccess: false,
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
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
                    controller: otpController.otpController.value,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    followingPinTheme: PinTheme(
                      width: AppSize.displayWidth(context) * 0.14,
                      height: AppSize.displayWidth(context) * 0.14,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorADB, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    disabledPinTheme: PinTheme(
                      width: AppSize.displayWidth(context) * 0.14,
                      height: AppSize.displayWidth(context) * 0.14,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.buttonColor, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onCompleted: (String verificationCode) {
                      // Close the keyboard by unfocusing
                      FocusScope.of(context).unfocus();

                      // Optionally, handle the OTP submission
                      debugPrint('Entered OTP: $verificationCode');
                    },
                    onChanged: (code) {
                      otpController.isAbleFun();
                      debugPrint('OTP Changed: $code');
                    },
                    focusedPinTheme: PinTheme(
                      width: AppSize.displayWidth(context) * 0.14,
                      height: AppSize.displayWidth(context) * 0.14,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.buttonColor, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: AppSize.displayWidth(context) * 0.14,
                      height: AppSize.displayWidth(context) * 0.14,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.buttonColor, width: 1),
                        borderRadius: BorderRadius.circular(8),
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
                    GestureDetector(
                      onTap: () {
                        sendOTP();
                      },
                      child: Text(
                        " Resend",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 50,
                          fontWeight: FontWeight.w500,
                          color: AppColors.colorF45,
                        ),
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
                        isLoading: otpController.isLoading.value,
                        isEnabled: otpController.isAble.value,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          print(otpController.verify.value);
                          // await ApiService().loginApi(
                          //     phone: Get.arguments != null &&
                          //             Get.arguments["no"] != null
                          //         ? Get.arguments["no"]
                          //         : "",
                          //     context: context,
                          //     loading: otpController.isLoading);
                          // otpController.otpController.value.clear();
                          try {
                            otpController.isLoading.value =
                            true;
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                              verificationId: otpController.verify.value,
                              smsCode: otpController.otpController.value.text,
                            );
                            await FirebaseAuth.instance
                                .signInWithCredential(credential);
                            // controller.postCheckMobileApi({"mobile": mobileNumberController.mobileNumberController.value.text.trim()});
                            await ApiService().loginApi(
                                phone: Get.arguments != null &&
                                        Get.arguments["no"] != null
                                    ? Get.arguments["no"]
                                    : "",
                                context: context,
                                loading: otpController.isLoading);
                            otpController.isLoading.value =
                                false; // Stop the loader in case of an error
                          } on FirebaseAuthException catch (error) {
                            otpController.isLoading.value =
                                false; // Stop the loader in case of an error

                            if (error.code == 'invalid-verification-code') {
                              customToast(
                                context,
                                "Invalid OTP",
                                ToastType.warning,
                              );
                            } else {
                              customToast(
                                context,
                                "Error: ${"Something went wrong"}",
                                ToastType.error,
                              );
                            }
                            otpController.isLoading.value =
                                false; // Stop the loader in case of an error
                          } catch (e) {
                            customToast(
                              context,
                              "Error: ${e}",
                              ToastType.error,
                            );
                            print("error >>>>>>>>>>>>> $e");
                            otpController.isLoading.value =
                                false; // Ensure the loader is stopped
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
