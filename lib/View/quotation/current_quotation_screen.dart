import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/past_order_controller.dart';
import '../../Data/Providers/api_constants.dart';
import '../../Data/Services/api_service.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_images.dart';
import '../../Util/Constant/app_size.dart';
import '../order_list/components/past_order_item_widget.dart';

class CurrentQuotationScreen extends GetView<PastOrderController> {
  const CurrentQuotationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.createOrderLoading.value
            ? Center(
          child: Container(
            height: AppSize.displayHeight(context) * 0.1,
            width: AppSize.displayHeight(context) * 0.1,
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(defaultRadius / 2),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ),
        )
            : controller.orderList.isNotEmpty
            ? ListView.separated(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            itemBuilder: (context, index) {
              return PastOrderItem(
                onTap: () {
                  Get.toNamed(RouteConstants.orderItemViewScreen);
                  controller.getOrderDetail(
                      controller.orderList[index].id?.toString() ?? "");
                },
                statusWidget: userType != 1 &&
                    controller.tapIndex.value != 0
                    ? InkWell(
                  onTap: () {
                    Get.toNamed(RouteConstants.quotationView);
                    controller.getQuotationDetail(controller
                        .orderList[index].ordersRef
                        ?.toString() ??
                        "");
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.receiptIcon,
                        height:
                        AppSize.displayHeight(context) * 0.022,
                      ).paddingOnly(
                          right:
                          AppSize.displayWidth(context) * 0.01),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: AppColors.color42B,
                        size: AppSize.displayHeight(context) * 0.02,
                      )
                    ],
                  ),
                )
                    : statusWidget(
                    context: context,
                    statusTitle:
                    controller.orderList[index].ordersStatus ??
                        ""),
                orderWidget: pastOrderWidget(
                    context: context,
                    orderDate: controller.orderList[index].ordersDate
                        ?.toIso8601String() ??
                        "",
                    orderNumber: controller.orderList[index].ordersNo
                        ?.toString() ??
                        "",
                    royaltyPoint: controller.orderList[index].ordersNo
                        ?.toString() ??
                        ""),
                networkImage:
                "${ApiConstants.imageBaseUrl}${controller.orderList[index].productCategoryImage?.toString() ?? ""}",
                title:
                controller.orderList[index].ordersRef?.toString() ??
                    "",
                subTitle: controller.orderList[index].productCategory,
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: controller.orderList.length)
            : Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "No Data Available",
                textAlign: TextAlign.center,
                style: GoogleFonts.ptSans(
                  color: AppColors.color333,
                  fontSize: Get.height / 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
