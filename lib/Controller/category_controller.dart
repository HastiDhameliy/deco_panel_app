import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController with WidgetsBindingObserver {
  RxBool isAccepted = false.obs;
  Rx<TextEditingController> titleCon = TextEditingController().obs;
  Rx<TextEditingController> descriptionCon = TextEditingController().obs;
}
