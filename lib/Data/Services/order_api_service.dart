import 'dart:convert';
import 'dart:developer';

import 'package:deco_flutter_app/Model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/OrderItemModel.dart';
import '../../Model/cart_model.dart';
import '../../Model/user_model.dart';
import '../../Util/custom/custom_toast.dart';
import '../Providers/api_constants.dart';
import 'api_service.dart';

class OrderApiService {
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******    Order API     *****                                        ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<OrderItemData>> fetchOrderApiUrl({
    required RxBool loading,
    required String status,
  }) async {
    List<OrderItemData> orderList = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.getOrderApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "order_status": status,
      });
      debugPrint("fetchBrandApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchBrandApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          orderList = orderModelFromJson(response.body).data ?? [];
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
    return orderList;
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******    Cart API     *****                                         ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<CartItem>> fetchCartListApiUrl({
    required RxBool loading,
  }) async {
    List<CartItem> cartList = [];
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.fetchCartApiUrl);
      debugPrint(url.toString());
      var response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token", // Correct usage
        },
      );
      debugPrint("fetchCartListApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchCartListApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          cartList = cartModelFromJson(response.body).data ?? [];
          loading.value = false;
        } else {
          loading.value = false;
        }
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchCartListApiUrl error:-${e.toString()}");
    }
    getdata();
    return cartList;
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******    Order Item API     *****                                   ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<OrderItemDataModel> fetchOrderDetailsApiUrl({
    required RxBool loading,
    required String orderId,
  }) async {
    OrderItemDataModel orderItemDataModel = OrderItemDataModel();
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.createOrderByIdApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "order_id": orderId
      });
      debugPrint("fetchOrderDetailsApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("fetchOrderDetailsApiUrl response:- ${response.body}");
        orderItemDataModel = orderItemDataModelFromJson(response.body);
        loading.value = false;
      } else {
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      log("fetchOrderDetailsApiUrl error:-${e.toString()}");
    }
    getdata();
    return orderItemDataModel;
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******   DELETE CART API     *****                                   ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> deleteCartListApiUrl({
    required RxBool loading,
    required BuildContext context,
    required String cartId,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.deleteCartApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "cart_id": cartId
      });
      debugPrint("deleteCartListApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("deleteCartListApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          customToast(
              context, "Cart Item deleted successfully", ToastType.success);
          loading.value = false;
        } else {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.warning);
          loading.value = false;
        }
      } else {
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.warning);
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      customToast(context, e.toString(), ToastType.error);
      log("deleteCartListApiUrl error:-${e.toString()}");
    }
    getdata();
    return loading.value;
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******   DELETE CART API     *****                                   ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> createOrderApiUrl({
    required RxBool loading,
    required BuildContext context,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.createOrderApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      });
      debugPrint("createOrderApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("createOrderApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.success);
          loading.value = false;
        } else {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.warning);
          loading.value = false;
        }
      } else {
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.warning);
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      customToast(context, e.toString(), ToastType.error);
      log("createOrderApiUrl error:-${e.toString()}");
    }
    getdata();
    return loading.value;
  }

  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///                                                                                                     ///
  ///                                ******   DELETE CART API     *****                                   ///
  ///                                                                                                     ///
  /// ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> updateCartApiUrl({
    required RxBool loading,
    required BuildContext context,
    required String cartId,
    required String cartQty,
  }) async {
    try {
      loading.value = true;
      var url = Uri.parse(ApiConstants.updateCartApiUrl);
      debugPrint(url.toString());
      var response = await http.post(url, headers: {
        "Authorization": "Bearer $token", // Correct usage
      }, body: {
        "cart_id": cartId,
        "cart_quantity": cartQty,
      });
      debugPrint("updateCartApiUrl statusCode:- ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("updateCartApiUrl response:- ${response.body}");

        if (jsonDecode(response.body)['code'] == 200) {
          customToast(context, "Quantity Updated", ToastType.success);
          loading.value = false;
        } else {
          customToast(context, jsonDecode(response.body)['msg'] ?? "",
              ToastType.warning);
          loading.value = false;
        }
      } else {
        customToast(
            context, jsonDecode(response.body)['msg'] ?? "", ToastType.warning);
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      customToast(context, e.toString(), ToastType.error);
      log("updateCartApiUrl error:-${e.toString()}");
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
