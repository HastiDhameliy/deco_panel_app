import 'dart:convert';
import 'dart:developer';

import 'package:deco_flutter_app/Model/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/product_model.dart';
import '../../Model/user_model.dart';
import '../../Util/custom/custom_toast.dart';
import '../Providers/api_constants.dart';
import 'api_service.dart';

bool isGuestLogin = false;

class ProductApiService {
  Future<List<BrandData>> fetchBrandApiUrl({
    required RxBool loading,
    required String id,
    required String subId,
  }) async {
    List<BrandData> brandList = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchBrandsApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": id,
        "product_sub_ctg_id": subId,
      });
      debugPrint("fetchBrandApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchBrandApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          brandList = brandModelFromJson(response.body).data ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchBrandApiUrl error:-${e.toString()}");
    }
    getdata();
    return brandList;
  }

  Future<List<ThicknessData>> fetchThicknessApiUrl({
    required RxBool loading,
    required String id,
    required String subId,
    required String brand,
  }) async {
    List<ThicknessData> thicknessList = [];
    try {
      log('$id/ $subId / $brand');
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchThicknessApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": id,
        "product_sub_ctg_id": subId,
        "product_brand": brand,
      });
      debugPrint("fetchThicknessApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchThicknessApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          thicknessList = thicknessModelFromJson(response.body).data ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchThicknessApiUrl error:-${e.toString()}");
    }
    getdata();
    return thicknessList;
  }

  Future<List<SizeData>> fetchSizeApiUrl({
    required RxBool loading,
    required String id,
    required String subId,
    required String brand,
    required String thickness,
    required String unit,
  }) async {
    List<SizeData> sizeList = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchSizeApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": id,
        "product_sub_ctg_id": subId,
        "product_brand": brand,
        "product_thickness": thickness,
        "product_unit": unit,
      });
      debugPrint("fetchThicknessApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchThicknessApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          sizeList = sizeModelFromJson(response.body).data ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchThicknessApiUrl error:-${e.toString()}");
    }
    getdata();
    return sizeList;
  }

  Future<List<CategoryProductItem>> fetchProductApiUrl({
    required RxBool loading,
    required String id,
    required String subId,
    required String brand,
    required String thickness,
    required String unit,
    required String size1,
    required String size2,
    required String sizeUnit,
  }) async {
    List<CategoryProductItem> categoryProductItem = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchProductApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": id,
        "product_sub_ctg_id": subId,
        "product_brand": brand,
        "product_thickness": thickness,
        "product_unit": unit,
        "product_size1": size1,
        "product_size2": size2,
        "product_size_unit": sizeUnit,
      });
      debugPrint("fetchThicknessApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchThicknessApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          categoryProductItem = productModelFromJson(response.body).data ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchThicknessApiUrl error:-${e.toString()}");
    }
    getdata();
    return categoryProductItem;
  }

  Future<bool> createCartApiUrl({
    required BuildContext context,
    required RxBool loading,
    required String id,
    required String subId,
    required String brand,
    required String thickness,
    required String unit,
    required String size1,
    required String size2,
    required String sizeUnit,
    required String qty,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.createCartApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "product_ctg_id": id,
        "product_sub_ctg_id": subId,
        "product_brand": brand,
        "product_thickness": thickness,
        "product_unit": unit,
        "product_size1": size1,
        "product_size2": size2,
        "product_size_unit": sizeUnit,
        "cart_quantity": qty,
      });
      debugPrint("createCartApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("createCartApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.success);
          loading.value = false;
        } else {
          customToast(context, "Something Went Wrong", ToastType.error);
          loading.value = false;
        }
      } else {
        customToast(context, "Something Went Wrong", ToastType.error);
        loading.value = false;
      }
    } catch (e) {
      customToast(context, "Something Went Wrong", ToastType.error);
      loading.value = false;
      log("createCartApiUrl error:-${e.toString()}");
    }
    getdata();
    return loading.value;
  }

  getdata() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    userDetails = userModelFromJson(preferences.getString("userModel") ?? "");
    token = userDetails.data?.token ?? "";
  }
}
