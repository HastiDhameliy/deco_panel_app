import 'package:deco_flutter_app/Model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/Services/api_service.dart';
import '../Data/Services/order_api_service.dart';
import '../Model/OrderItemModel.dart';
import '../Model/order_model.dart';
import '../Model/quotation_model.dart';

class PastOrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rx<TabController> tabController;
  RxList<OrderItemData> orderList = <OrderItemData>[].obs;
  RxList<CartItem> cartList = <CartItem>[].obs;
  Rx<OrderItemDataModel> orderItemModel = OrderItemDataModel().obs;
  Rx<QuotationModel> quotationModel = QuotationModel().obs;
  RxInt tapIndex = 0.obs;
  RxBool loading = false.obs;
  RxBool quotationLoading = false.obs;
  RxBool updateQuoLoading = false.obs;
  RxBool deleteCartLoading = false.obs;
  RxBool updateCartLoading = false.obs;
  RxBool cartLoading = false.obs;
  RxBool createOrderLoading = false.obs;
  RxBool orderDetailsLoading = false.obs;
  RxBool creatingLoading = false.obs;
  var isLoading = false.obs;

  Future<void> fetchData() async {
    try {
      // Start the loading animation
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(
          const Duration(seconds: 2)); // Replace with actual API call

      // Keep the animation visible for an additional 5 seconds
      await Future.delayed(const Duration(seconds: 5));
    } finally {
      // Hide the animation
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this).obs; // Two tabs
    if (userType == 1) getOrderList();
    getOrder("1");
    super.onInit();
  }

  @override
  void onClose() {
    tabController.value.dispose();
    super.onClose();
  }

  void getOrder(String status) async {
    orderList.value = await OrderApiService()
        .fetchOrderApiUrl(loading: loading, status: status);
  }

  void getOrderList() async {
    cartList.value =
        await OrderApiService().fetchCartListApiUrl(loading: cartLoading);
  }

  Future<void> deleteCartItemApi(BuildContext context, String cartId) async {
    await OrderApiService().deleteCartListApiUrl(
        loading: deleteCartLoading, context: context, cartId: cartId);
  }

  Future<void> createOrderApi(BuildContext context) async {
    await OrderApiService()
        .createOrderApiUrl(loading: createOrderLoading, context: context);
  }

  getOrderDetail(String orderId) async {
    orderItemModel.value = await OrderApiService().fetchOrderDetailsApiUrl(
      loading: orderDetailsLoading,
      orderId: orderId,
    );
  }

  void getQuotationDetail(String orderref) async {
    quotationModel.value = await OrderApiService().getQuotationApiUrl(
      loading: quotationLoading,
      orderref: orderref,
    );
  }

  Future<void> createQuotation(BuildContext context, String orderId) async {
   await OrderApiService().createQuotationApi(
        loading: creatingLoading, context: context, orderId: orderId);
  }
}
