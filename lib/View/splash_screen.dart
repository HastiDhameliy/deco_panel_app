import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import '../Data/Providers/session_manager.dart';
import '../Data/Services/api_service.dart';
import '../Model/user_model.dart';
import '../RoutesManagment/routes.dart';
import '../Util/Constant/app_images.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForUpdate();
    // checkAndRequestCameraPermissions(context);
    getUserData(context);
  }

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
      body: Center(
        child: Image.asset(
          AppImages.logo,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
