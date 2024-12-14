import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController with WidgetsBindingObserver {
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;
  RxString verify = ''.obs;
  RxInt resendToken = 0.obs;
  late Timer _timer;
  final start = 60.obs;
  FocusNode otp1FocusNode = FocusNode();

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
    super.onReady();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start.value < 1) {
        timer.cancel();
      } else {
        start.value = start.value - 1;
      }
    });
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  RxBool isAbleFun() {
    isAble.value = otpController.value.text.trim().isNotEmpty &&
        otpController.value.text.length == 6;
    debugPrint("is login able :${isAble.value}");
    return isAble;
  }
}
