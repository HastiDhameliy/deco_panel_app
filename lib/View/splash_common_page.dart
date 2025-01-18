import 'dart:async';

import 'package:deco_flutter_app/View/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';

import '../Data/Providers/session_manager.dart';
import '../Data/Services/api_service.dart';
import '../Model/user_model.dart';
import '../RoutesManagment/routes.dart';
import 'auth/login_screen.dart';

class SplashCommonPage extends StatefulWidget {
  const SplashCommonPage({super.key});

  @override
  State<SplashCommonPage> createState() => _SplashCommonPageState();
}

class _SplashCommonPageState extends State<SplashCommonPage> {
  @override
  void initState() {
    super.initState();
    // Set the timer for 2 seconds before navigating to the next screen
    checkForUpdate();
    // checkAndRequestCameraPermissions(context);
    getUserData(context);
  }

  AppUpdateInfo? _updateInfo;

  Future<void> checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        startFlexibleUpdate();
      }
    } catch (e) {
      print("Error checking for updates: $e");
    }
  }

  // Start a flexible update
  Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
      print("Update installed successfully.");
    } catch (e) {
      print("Error during update: $e");
    }
  }

  Future<void> getUserData(BuildContext context) async {
    UserModel userDetails = UserModel();
    token = (await SessionManager().getAuthToken()) ?? "";

    await Future.delayed(const Duration(seconds: 3));

    if (token.isEmpty) {
      Get.offAllNamed(RouteConstants.loginScreen);
      return;
    }

    // Call API if token exists
    if (token.isNotEmpty) {
      await ApiService().getdata();
    }

    await ApiService().loginApi(
      phone: userDetails.data?.user?.mobile ?? "",
      context: context,
      loading: otpController.isLoading,
      password: userDetails.data?.user?.cpassword ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/AGS_LOGO.png",
                  height: Get.height * 0.15,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                RichText(
                  text: TextSpan(
                    text: "AG ",
                    style: GoogleFonts.roboto(
                      fontSize: Get.height / 28,
                      color: const Color(0xFF076894),
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(
                        text: "Solutions",
                        style: GoogleFonts.roboto(
                          fontSize: Get.height / 28,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF076894),
            child: Text(
              "WEBSITE | WEB APPLICATION\nMOBILE APPLICATION | DIGITAL MARKETING",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: Get.height / 50,
                color: const Color(0xFFffffff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.15,
          ),
        ],
      ),
    );
  }
}
