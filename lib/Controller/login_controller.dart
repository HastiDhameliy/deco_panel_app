import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController with WidgetsBindingObserver {
  RxBool isAccepted = false.obs;
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  RxBool isAble2 = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  Rx<TextEditingController> numberController = TextEditingController().obs;
  final GlobalKey<FormState> loginStoreFormKey = GlobalKey<FormState>();

  Rx<TextEditingController> nameCon = TextEditingController().obs;
  Rx<TextEditingController> mobileCon = TextEditingController().obs;
  Rx<TextEditingController> emailCon = TextEditingController().obs;
  Rx<TextEditingController> areaCon = TextEditingController().obs;
  Rx<TextEditingController> addressCon = TextEditingController().obs;
  Rx<TextEditingController> imageCon = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    if (Get.arguments != null && Get.arguments["Number"] != null) {
      mobileCon.value.text = Get.arguments["Number"];
    }
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
    isAbleFun2();
    super.onReady();
  }

  void clearAllController() {
    nameCon.value.clear();
    mobileCon.value.clear();
    emailCon.value.clear();
    areaCon.value.clear();
    addressCon.value.clear();
    imageCon.value.clear();
  }

  RxBool isAbleFun2() {
    isAble2.value = nameCon.value.text.trim().isNotEmpty &&
        mobileCon.value.text.trim().isNotEmpty &&
        emailCon.value.text.trim().isNotEmpty &&
        addressCon.value.text.trim().isNotEmpty &&
        imageCon.value.text.trim().isNotEmpty &&
        mobileCon.value.text.length == 10;
    print("is sign up able :${isAble2.value}");
    return isAble2;
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

  Rx<File> selectedImage = File("").obs; // To store the selected image
  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker

// Function to pick an image
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source, // Source: gallery or camera
        imageQuality: 85, // Adjust the image quality (optional)
      );

      if (image != null) {
        imageCon.value.text =
            image.path.split("/").last; // Set image name in the text field
        selectedImage.value =
            File(image.path); // Save the image to a File object
        isAbleFun2(); // Enable functionality (if applicable)
      } else {
        debugPrint('No image selected');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }
}
