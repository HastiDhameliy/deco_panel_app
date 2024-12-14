import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:deco_flutter_app/Model/offer_model.dart';
import 'package:deco_flutter_app/Model/sub_category_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/bottom_nav_controller.dart';
import '../../Model/product_category_model.dart';
import '../../Model/slider_model.dart';
import '../../Model/user_detail_model.dart';
import '../../Model/user_model.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/custom/custom_toast.dart';
import '../Providers/api_constants.dart';
import '../Providers/session_manager.dart';

UserModel userDetails = UserModel();
String token = "";

bool isGuestLogin = false;

class ApiService {
  Future<dynamic> mobileApi(
      {required String phone,
      required BuildContext context,
      required RxBool loading}) async {
    var responsed;
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.checkMobileApiUrl + phone);
      debugPrint(url.toString());
      var response = await http.post(url);
      debugPrint("mobileApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("mobileApi response:- ${response.body}");
        responsed = jsonDecode(response.body);
        if (jsonDecode(response.body)['code'] == 200) {
          //Get.offAllNamed(RouteConstants.otpScreen, arguments: {"no": phone});
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.success);
          loading.value = false;
          return responsed;
        } else {
          loading.value = false;
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        }
      } else {
        loading.value = false;
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
      }
    } catch (e) {
      loading.value = false;
      log("mobileApi error:-${e.toString()}");
    }
    return responsed;
  }

  Future<bool> updateUserApiUrl({
    required BuildContext context,
    required RxBool loading,
    required String name,
    required String mobile,
    required String email,
    required String address,
    required String area,
    required String profilePhoto,
  }) async {
    try {
      loading.value = true;

      // Prepare the multipart request
      final uri = Uri.parse("${ApiConstants.createUserUrl}");
      var request = http.MultipartRequest('POST', uri);

      print({
        'name': name,
        'email': email,
        'address': address,
        'mobile': mobile,
        'state': area,
        'user_image': profilePhoto.split('/').last,
      });
      request.fields.addAll({
        'name': name,
        'email': email,
        'address': address,
        'mobile': mobile,
        'state': area,
      });
      if (profilePhoto.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'user_image',
            File(profilePhoto).readAsBytesSync(),
            filename: profilePhoto.split('/').last,
          ),
        );
      }

      // Send the request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      debugPrint("updateUserApiUrl statusCode:- ${response.statusCode}");
      debugPrint("updateUserApiUrl response:- $responseBody");

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);

        if (responseJson['code'] == 200) {
          Get.offAllNamed(RouteConstants.otpScreen, arguments: {"no": mobile});
          customToast(context, responseJson['msg'] ?? "", ToastType.success);
          loading.value = false;
          return true;
        } else {
          customToast(context, responseJson['msg'] ?? "", ToastType.error);
          loading.value = false;
          return false;
        }
      } else {
        var errorJson = jsonDecode(responseBody);
        customToast(context, errorJson['msg'] ?? "Error", ToastType.error);
        loading.value = false;
        return false;
      }
    } catch (e) {
      customToast(context, "Something Went Wrong", ToastType.error);
      loading.value = false;
      log("updateUserApiUrl error:-${e.toString()}");
      return false;
    }
  }

  Future<bool> loginApi(
      {required String phone,
      required BuildContext context,
      required RxBool loading}) async {
    UserModel userDetails = UserModel();
    try {
      loading.value = true;
      var url = Uri.parse("${ApiConstants.loginApiUrl}$phone&password=123456");
      debugPrint(url.toString());
      var response = await http.post(url);
      debugPrint("loginApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("loginApi response:- ${response.body}");
        if (jsonDecode(response.body)['code'] == 200) {
          userDetails = userModelFromJson(response.body);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userModel", jsonEncode(userDetails));
          Get.offAllNamed(RouteConstants.animatedBottomNavBar);
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.success);
          await SessionManager().saveAuthToken(userDetails.data?.token ?? "");
          BottomNavController con = Get.put(BottomNavController());
          loading.value = false;
        } else {
          loading.value = false;
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        }
      } else {
        loading.value = false;
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
      }
    } catch (e) {
      loading.value = false;
      log("loginApi error:-${e.toString()}");
    }
    getdata();
    return loading.value;
  }

  Future<SliderModel> fetchSliderApi(
      {required BuildContext context, required RxBool loading}) async {
    SliderModel sliderModel = SliderModel();
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchSliderApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      });
      debugPrint("fetchSliderApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchSliderApi response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          sliderModel = sliderModelFromJson(response.body);
          loading.value = false;
        } else {
          loading.value = false;
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        }
      } else {
        loading.value = false;
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
      }
    } catch (e) {
      loading.value = false;
      log("fetchSliderApi error:-${e.toString()}");
    }
    getdata();
    return sliderModel;
  }

  Future<ProductCategoryModel> fetchProductCategoryApi(
      {required RxBool loading}) async {
    ProductCategoryModel productCategoryModel = ProductCategoryModel();
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchProductCategoryApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      });
      debugPrint("fetchSliderApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchSliderApi response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          productCategoryModel = productCategoryModelFromJson(response.body);
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchSliderApi error:-${e.toString()}");
    }
    getdata();
    return productCategoryModel;
  }

  Future<SubCategoryModel> fetchSubCategoryApiUrl(
      {required RxBool loading, required String productCtgId}) async {
    SubCategoryModel subCategoryModel = SubCategoryModel();
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchSubCategoryApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": productCtgId
      });
      debugPrint("fetchSubCategoryApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchSubCategoryApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          subCategoryModel = subCategoryModelFromJson(response.body);
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchSubCategoryApiUrl error:-${e.toString()}");
    }
    getdata();
    return subCategoryModel;
  }

  Future<UserDataModel> fetchUserApiUrl({
    required RxBool loading,
  }) async {
    UserDataModel userModel = UserDataModel();
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchProfileApiUrl);
      debugPrint(url.toString());
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token", // Correct usage
        },
      );
      debugPrint("fetchUserApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchUserApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          userModel = userDataModelFromJson(response.body);
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchUserApiUrl error:-${e.toString()}");
    }
    getdata();
    return userModel;
  }

  Future<bool> createFeedbackApi({
    required BuildContext context,
    required RxBool loading,
    required String sub,
    required String des,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.addFeedbackApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "feedback_subject": sub,
        "feedback_description": des,
      });
      debugPrint("createFeedbackApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("createFeedbackApi response:- ${response.body}");
        if (jsonDecode(response.body)['code'] == 200) {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.success);
          loading.value = false;
        } else {
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
          loading.value = false;
        }
      } else {
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      customToast(context, e.toString(), ToastType.error);
      log("createFeedbackApi error:-${e.toString()}");
    }
    getdata();
    return loading.value;
  }

  Future<List<Offerbanner>> fetchOfferApi({
    required RxBool loading,
  }) async {
    List<Offerbanner> offerModel = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchOfferApiUrl);
      debugPrint(url.toString());
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token", // Correct usage
        },
      );
      debugPrint("fetchOfferApi statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchOfferApi response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          offerModel = offerModelFromJson(response.body).offerbanner ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchOfferApi error:-${e.toString()}");
    }
    getdata();
    return offerModel;
  }

  getdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userDetails = userModelFromJson(preferences.getString("userModel") ?? "");
    token = userDetails.data?.token ?? "";
  }
}
