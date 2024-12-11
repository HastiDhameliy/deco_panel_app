import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/Providers/session_manager.dart';
import '../Data/Services/api_service.dart';
import '../RoutesManagment/routes.dart';
import '../Util/Constant/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkAndRequestCameraPermissions(context);
    getUserData();
  }

  getUserData() async {
    token = (await SessionManager().getAuthToken()) ?? "";

    // print(userToken);
    // print(userRole);

    Timer(
      const Duration(seconds: 3),
      () {
        token == ""
            ? Get.offAllNamed(RouteConstants.loginScreen)
            : Get.offAllNamed(RouteConstants.animatedBottomNavBar);
      },
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
