import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/past_order_controller.dart';

class OrderItemViewScreen extends GetView<PastOrderController> {
  const OrderItemViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.black.withOpacity(0.4),
        flexibleSpace: Container(
            decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Light shadow color
              blurRadius: 10.0, // Soften the shadow
              offset: const Offset(0, 4), // Shadow appears below the AppBar
            ),
          ],
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Order Details",
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 37,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => controller.loading.value
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
            : controller.orderItemModel.value.orderSub != null &&
                    controller.orderItemModel.value.orderSub!.isNotEmpty
                ? SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonTextWidget(
                          context: context,
                          title: "Order No",
                          subTitle: controller
                                  .orderItemModel.value.order?.ordersNo
                                  ?.toString() ??
                              "",
                        ),
                        commonTextWidget(
                          context: context,
                          title: "Order Date",
                          subTitle: formatDateFromString(
                            controller.orderItemModel.value.order?.ordersDate
                                    ?.toString() ??
                                "",
                          ),
                        ).paddingOnly(bottom: defaultPadding),
                        Text(
                          "Order Items ",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            color: AppColors.colorF45,
                            fontSize: Get.height / 50,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            itemBuilder: (context, index) {
                              print(controller.orderItemModel.value
                                  .orderSub![index].ordersSubProduct);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      // Light shadow color
                                      blurRadius: 10.0,
                                      // Soften the shadow
                                      offset: const Offset(0,
                                          4), // Shadow appears below the AppBar
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(defaultRadius),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .orderItemModel
                                                .value
                                                .orderSub![index]
                                                .productSubCategory ??
                                                "",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.buttonColor,
                                              fontSize: Get.height / 52,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Brand : ",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.roboto(
                                                  color: AppColors.colorF45,
                                                  fontSize: Get.height / 55,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  controller
                                                          .orderItemModel
                                                          .value
                                                          .orderSub![index]
                                                          .ordersSubBrand ??
                                                      "",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.roboto(
                                                    color: AppColors.color333,
                                                    fontSize: Get.height / 55,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Size : ",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.roboto(
                                                  color: AppColors.colorF45,
                                                  fontSize: Get.height / 55,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${controller.orderItemModel.value.orderSub![index].ordersSubSize1?.toString() ?? ""}x${controller.orderItemModel.value.orderSub![index].ordersSubSize2?.toString() ?? ""} ${controller.orderItemModel.value.orderSub![index].ordersSubSizeUnit?.toString() ?? ""}, ${controller.orderItemModel.value.orderSub![index].ordersSubThickness ?? ""}${controller.orderItemModel.value.orderSub![index].ordersSubUnit ?? ""} ",
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.roboto(
                                                    color: AppColors.color333,
                                                    fontSize: Get.height / 55,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: defaultPadding * 2,
                                          vertical: defaultPadding / 10),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.colorF45.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(defaultRadius / 2),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Qty : ",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.color333,
                                              fontSize: Get.height / 55,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${controller.orderItemModel.value.orderSub![index].ordersSubQuantity ?? ""}",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.color333,
                                              fontSize: Get.height / 55,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: controller
                                .orderItemModel.value.orderSub!.length),
                      ],
                    ),
                  )
                : Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "No Order Available",
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
      ),
    );
  }

  String formatDateFromString(String inputDate) {
    // Parse the input date string into a DateTime object
    try {
      DateTime date = DateTime.parse(inputDate);

      // List of month abbreviations
      const List<String> months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ];

      // Format the date
      String formattedDate = "${date.day}-${date.month}-${date.year}";
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  Widget commonTextWidget(
      {String? title, String? subTitle, BuildContext? context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${title ?? ""} : ",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
            color: AppColors.hintColor2,
            fontSize: Get.height / 55,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          flex: 8,
          child: Text(
            subTitle ?? "",
            textAlign: TextAlign.end,
            style: GoogleFonts.roboto(
              color: AppColors.color333,
              fontSize: Get.height / 55,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
