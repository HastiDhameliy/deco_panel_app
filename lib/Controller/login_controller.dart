import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with WidgetsBindingObserver {
  RxBool isAccepted = false.obs;
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  Rx<TextEditingController> numberController = TextEditingController().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
    super.onReady();
  }

  RxBool isAbleFun() {
    isAble.value = numberController.value.text.trim().isNotEmpty &&
        numberController.value.text.length == 10 &&
        isAccepted.isTrue;
    debugPrint(
        "is login able :${numberController.value.text.trim().isNotEmpty && numberController.value.text.length == 10 && isAccepted.isTrue}");
    return (numberController.value.text.trim().isNotEmpty &&
            numberController.value.text.length == 10 &&
            isAccepted.isTrue)
        .obs;
  }
}
