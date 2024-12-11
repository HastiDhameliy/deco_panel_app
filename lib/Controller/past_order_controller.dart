import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rx<TabController> tabController;
  RxInt tapIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this).obs; // Two tabs
    super.onInit();
  }

  @override
  void onClose() {
    tabController.value.dispose();
    super.onClose();
  }
}
