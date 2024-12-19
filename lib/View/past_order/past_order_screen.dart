import 'package:deco_flutter_app/Data/Providers/api_constants.dart';
import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/past_order_controller.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';
import '../order_list/components/past_order_item_widget.dart';

class PastOrderScreen extends GetView<PastOrderController> {
  const PastOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Obx(
        () => Column(
          children: [
            TabBar(
              controller: controller.tabController.value,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              onTap: (value) {
                controller.tapIndex.value = value;
                if (value == 0) {
                  controller.getOrder("1");
                } else {
                  controller.getOrder("2");
                }
              },
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppColors.colorF45, // Line color
                  width: 2, // Line thickness
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.zero,
              indicatorWeight: 3,
              // Indicator aligns with the label
              labelPadding: EdgeInsets.zero,
              indicatorPadding: const EdgeInsets.only(bottom: 2),
              // Removes padding around labels
              tabs: [
                Tab(
                  child: Obx(
                    () => Container(
                      alignment: Alignment.center,
                      height: AppSize.displayHeight(context) * 0.3,
                      decoration: BoxDecoration(
                        color: controller.tapIndex.value == 0
                            ? Colors.white
                            : AppColors.color7B7,
                        border: Border(
                          top: const BorderSide(color: AppColors.color262),
                          right: const BorderSide(color: AppColors.color262),
                          bottom: BorderSide(
                              color: controller.tapIndex.value != 0
                                  ? AppColors.color262
                                  : Colors.transparent // Border for square
                              ),
                        ),
                      ),
                      child: Text(
                        "Current Orders",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 55,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color393,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Obx(
                    () => Container(
                      alignment: Alignment.center,
                      height: AppSize.displayHeight(context) * 0.3,
                      decoration: BoxDecoration(
                        color: controller.tapIndex.value == 1
                            ? Colors.white
                            : AppColors.color7B7,
                        border: Border(
                          top: const BorderSide(color: AppColors.color262),
                          right: const BorderSide(color: AppColors.color262),
                          bottom: BorderSide(
                              color: controller.tapIndex.value != 1
                                  ? AppColors.color262
                                  : Colors.transparent),
                          left: const BorderSide(color: AppColors.color262),
                        ), // Border for square
                      ),
                      child: Text(
                        "Past Orders",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 55,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color393,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.tabController.value,
                children: [
                  orderListView(context),
                  orderListView(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderListView(BuildContext context) {
    return Obx(
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
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
    );
  }
}
