import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController with WidgetsBindingObserver {
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
    super.onReady();
  }

  RxBool isAbleFun() {
    isAble.value = otpController.value.text.trim().isNotEmpty &&
        otpController.value.text.length == 6;
    debugPrint("is login able :${isAble.value}");
    return isAble;
  }
}
