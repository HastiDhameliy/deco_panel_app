import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:deco_flutter_app/Model/offer_model.dart';
import 'package:deco_flutter_app/Model/sub_category_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
int userType = 1;

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
          // customToast(context, jsonDecode(response.body)['msg'] ?? "",
          //     ToastType.success);
          loading.value = true;
          return responsed;
        } else {
          loading.value = false;

          if ((jsonDecode(response.body)['msg'] ?? "") ==
              "Mobile Number is Not Registered") {
            Get.offAllNamed(RouteConstants.editProfileScreen, arguments: {
              "Number": phone,
            });
          }
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

  Future<dynamic> updateUserApiUrl({
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
          // customToast(context, responseJson['msg'] ?? "", ToastType.success);
          loading.value = true;
          return responseJson;
        } else {
          // customToast(context, responseJson['msg'] ?? "", ToastType.error);
          loading.value = false;
          return responseJson;
        }
      } else {
        var errorJson = jsonDecode(responseBody);
        customToast(context, errorJson['msg'] ?? "Error", ToastType.error);
        loading.value = false;
        return errorJson;
      }
    } catch (e) {
      customToast(context, "Something Went Wrong", ToastType.error);
      loading.value = false;
      log("updateUserApiUrl error:-${e.toString()}");
      return false;
    }
  }

  Future<bool> loginApi({
    required String phone,
    required String password,
    required BuildContext context,
    required RxBool loading,
  }) async {
    UserModel userDetails = UserModel();
    loading.value = true;
    try {
      var url =
          Uri.parse("${ApiConstants.loginApiUrl}$phone&password=$password");
      debugPrint("Requesting URL: $url");

      var response = await http.post(url);
      debugPrint("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        debugPrint("Response body: ${response.body}");

        if (jsonResponse['code'] == 200) {
          userDetails = userModelFromJson(response.body);

          // Save user details in shared preferences
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("userModel", jsonEncode(userDetails));

          // Save auth token
          await SessionManager().saveAuthToken(userDetails.data?.token ?? "");

          // Navigate to home screen
          Get.offAllNamed(RouteConstants.animatedBottomNavBar);

          // Show success toast
          customToast(context, jsonResponse['msg'] ?? "Login successful",
              ToastType.success);
        } else {
          customToast(
              context, jsonResponse['msg'] ?? "Login failed", ToastType.error);
        }
      } else if (response.statusCode == 403) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        var jsonResponse = jsonDecode(response.body);
        debugPrint("Response body: ${response.body}");
        showToast(jsonResponse['msg'] ?? "Account Inactive");
        prefs.clear();
        Get.offAllNamed(RouteConstants.loginScreen);
      } else {
        customToast(
            context, "Server error: ${response.statusCode}", ToastType.error);
      }
    } catch (e) {
      log("Login API error: ${e.toString()}");
      customToast(
          context, "An error occurred. Please try again.", ToastType.error);
    } finally {
      loading.value = false;
    }

    return !loading.value;
  }

  Future<SliderModel> fetchSliderApi(
      {required BuildContext context, required RxBool loading}) async {
    SliderModel sliderModel = SliderModel();
    token = (await SessionManager().getAuthToken()) ?? "";
    try {
      if (userType == 1) {
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
            customToast(context, jsonDecode(response.body)['msg'] ?? "",
                ToastType.error);
          }
        } else {
          loading.value = false;
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        }
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
      if (userType == 1) {
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
      if (userType == 1) {
        loading.value = true;
        var url = Uri.parse(ApiConstants.fetchSubCategoryApiUrl);
        debugPrint(url.toString());
        var response = await http.post(url, headers: {
          "Authorization": "Bearer $token", // Correct usage
        }, body: {
          "product_ctg_id": productCtgId
        });
        debugPrint(
            "fetchSubCategoryApiUrl statusCode:- ${response.statusCode}");
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
          return true;
        } else {
          customToast(
              context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
          loading.value = false;
          return false;
        }
      } else {
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.error);
        loading.value = false;
        return false;
      }
    } catch (e) {
      loading.value = false;
      customToast(context, e.toString(), ToastType.error);
      log("createFeedbackApi error:-${e.toString()}");
    }
    getdata();
    return false;
  }

  Future<List<Offerbanner>> fetchOfferApi({
    required RxBool loading,
  }) async {
    List<Offerbanner> offerModel = [];
    try {
      if (userType == 1) {
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
      }
    } catch (e) {
      loading.value = false;
      log("fetchOfferApi error:-${e.toString()}");
    }
    getdata();
    return offerModel;
  }

  Future getdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userModelString = preferences.getString("userModel");

    if (userModelString != null && userModelString.isNotEmpty) {
      try {
        userDetails = userModelFromJson(userModelString);

        print("username ${userDetails.data?.user?.name} ::: "
            "${userDetails.data?.user?.mobile} :: "
            "${userDetails.data?.user?.cpassword}");

        token = userDetails.data?.token ?? "";
        userType = userDetails.data?.user?.userTypeId ?? 1;
      } catch (e) {
        print("Error decoding userModel JSON: $e");
        // Optional: clear corrupted data
        // await preferences.remove("userModel");
      }
    } else {
      print("No userModel found in SharedPreferences");
    }
  }
}
