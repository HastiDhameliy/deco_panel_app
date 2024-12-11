import 'dart:io';

import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/user_detail_model.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxBool isAble = false.obs;
  Rx<TextEditingController> nameCon = TextEditingController().obs;
  Rx<TextEditingController> mobileCon = TextEditingController().obs;
  Rx<TextEditingController> emailCon = TextEditingController().obs;
  Rx<TextEditingController> areaCon = TextEditingController().obs;
  Rx<TextEditingController> addressCon = TextEditingController().obs;
  Rx<TextEditingController> imageCon = TextEditingController().obs;
  Rx<UserDataModel> useDataModel = UserDataModel().obs;

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    // TODO: implement onInit
    getProfileData();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    isAbleFun();
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

  RxBool isAbleFun() {
    isAble.value = nameCon.value.text.trim().isNotEmpty &&
        mobileCon.value.text.trim().isNotEmpty &&
        emailCon.value.text.trim().isNotEmpty &&
        addressCon.value.text.trim().isNotEmpty &&
        imageCon.value.text.trim().isNotEmpty &&
        mobileCon.value.text.length == 10;
    debugPrint("is login able :${isAble.value}");
    return isAble;
  }

  void getProfileData() async {
    useDataModel.value = await ApiService().fetchUserApiUrl(
      loading: isLoading,
    );
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
        imageCon.value.text = image.path.split("/").last;
        selectedImage.value =
            File(image.path); // Save the image to a File object
        isAbleFun();
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
