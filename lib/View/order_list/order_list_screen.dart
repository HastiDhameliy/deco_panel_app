import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/bottom_nav_controller.dart';
import '../../Controller/past_order_controller.dart';
import '../../Data/Providers/api_constants.dart';
import '../../Data/Services/order_api_service.dart';
import '../../RoutesManagment/routes.dart';
import 'components/past_order_item_widget.dart';

class OrderListScreen extends GetView<PastOrderController> {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
        () => controller.cartList.isNotEmpty
            ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    itemBuilder: (context, index) {
                      return PastOrderItem(
                        value: controller.cartList[index].isSelected,
                        size:
                            "${controller.cartList[index].productsSize1 ?? ""}*${controller.cartList[index].productsSize2 ?? ""} ${controller.cartList[index].productsSizeUnit ?? ""}",
                        brand: controller.cartList[index].productsBrand ?? "",
                        thickness:
                            "${controller.cartList[index].productsThickness ?? ""} ${controller.cartList[index].productsUnit ?? ""}",
                        onDeletePressed: () {
                          deleteDialog(
                            context: context,
                            onPressed: () async {
                              await controller.deleteCartItemApi(
                                  context,
                                  controller.cartList[index].id?.toString() ??
                                      "");
                              controller.cartList.removeAt(index);
                              Get.back();
                            },
                          );
                        },
                        onChanged: (val) {
                          controller.cartList[index].isSelected?.value =
                              val ?? false;
                        },
                        initialValue: controller.cartList[index].cartQuantity,
                        onQtyValueChanged: (val) async {
                          await OrderApiService().updateCartApiUrl(
                              loading: controller.updateCartLoading,
                              context: context,
                              cartId:
                                  controller.cartList[index].id?.toString() ??
                                      "",
                              cartQty: val.toString());
                        },
                        networkImage: controller
                                    .cartList[index].productCategoryImage !=
                                null
                            ? "${ApiConstants.imageBaseUrl}${controller.cartList[index].productCategoryImage?.toString() ?? ""}"
                            : "",
                        title: controller.cartList[index].productsBrand
                                ?.toString() ??
                            "",
                        subTitle: controller.cartList[index].productsCatgId
                                ?.toString() ??
                            "",
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: controller.cartList.length)
                .paddingOnly(bottom: AppSize.displayHeight(context) * 0.05)
            : Center(
                child: Text(
                  "No Cart Available",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ptSans(
                    color: AppColors.color333,
                    fontSize: Get.height / 45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
      ),
      bottomSheet: Container(
        height: AppSize.displayHeight(context) * 0.08,
        color: AppColors.bgColor,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: AppSize.displayWidth(context) * 0.04,
                  ),
                  Expanded(
                    child: CommonButton(
                      padding: EdgeInsets.zero,
                      enabledColor: AppColors.color333,
                      text: "Add Items",
                      onPressed: () {
                        BottomNavController con =
                            Get.find<BottomNavController>();

                        if (con.productCategoryModel.value.data != null &&
                            con.productCategoryModel.value.data!.isNotEmpty) {
                          con.categoryData.value =
                              con.productCategoryModel.value.data!.first;
                          con.getSubCategoryData(con
                                  .productCategoryModel.value.data?.first.id
                                  .toString() ??
                              "");
                          Get.toNamed(RouteConstants.categoryItemScreen)?.then(
                            (value) {
                              controller.getOrderList();
                            },
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: AppSize.displayWidth(context) * 0.04,
                  ),
                  Expanded(
                    child: Obx(
                      () => CommonButton(
                        padding: EdgeInsets.zero,
                        isEnabled: controller.cartList.isNotEmpty,
                        isLoading: controller.createOrderLoading.value,
                        text: "Get Quotation",
                        onPressed: () async {
                          await controller.createOrderApi(context);
                          controller.getOrderList();
                          Get.find<PastOrderController>().tapIndex.value = 0;
                          Get.find<BottomNavController>().changeIndex(1);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSize.displayWidth(context) * 0.04,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.displayHeight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  void deleteDialog(
      {required BuildContext context, required void Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.bgColor,
          surfaceTintColor: AppColors.bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 50,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Remove Item?",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Are you sure you want to remove this item from your cart? This action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CommonButton(
                        enabledColor: AppColors.color333,
                        padding: EdgeInsets.symmetric(
                            vertical: AppSize.displayHeight(context) * 0.01),
                        text: "Cancel",
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                      width: AppSize.displayWidth(context) * 0.02,
                    ),
                    Expanded(
                      child: Obx(
                        () => CommonButton(
                          isLoading: controller.deleteCartLoading.value,
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.displayHeight(context) * 0.01),
                          text: "Remove",
                          onPressed: onPressed,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
