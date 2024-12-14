import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController with WidgetsBindingObserver {
  RxBool isAccepted = false.obs;
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  Rx<TextEditingController> titleCon = TextEditingController().obs;
  Rx<TextEditingController> descriptionCon = TextEditingController().obs;
  final GlobalKey<FormState> feedbackFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
    super.onReady();
  }

  RxBool isAbleFun() {
    isAble.value = titleCon.value.text.trim().isNotEmpty &&
        descriptionCon.value.text.trim().isNotEmpty;
    debugPrint("is login able :${isAble.value}");
    return isAble;
  }
}
