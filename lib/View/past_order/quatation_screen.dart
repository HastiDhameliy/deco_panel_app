import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/past_order_controller.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';
import '../../widget/common_button.dart';
import 'components/table.dart';

class QuotationView extends GetView<PastOrderController> {
  const QuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: Colors.black.withOpacity(0.1),
                // Light shadow color
                blurRadius: 10.0,
                // Soften the shadow
                offset: const Offset(0, 4), // Shadow appears below the AppBar
              ),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Quotation",
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Obx(
        () => controller.quotationLoading.value
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
            : controller.quotationModel.value.quotationSub != null &&
                    controller.quotationModel.value.quotationSub!.isNotEmpty
                ? SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.displayWidth(context) * 0.04,
                        vertical: AppSize.displayHeight(context) * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Estimate",
                          style: GoogleFonts.ptSans(
                            fontSize: Get.height / 45,
                            fontWeight: FontWeight.w700,
                            color: AppColors.color333,
                          ),
                        ).paddingOnly(
                            bottom: AppSize.displayHeight(context) * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "User Name : ${controller.quotationModel.value.quotation?.fullName ?? ""}",
                                style: GoogleFonts.ptSans(
                                  fontSize: Get.height / 55,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.color333,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ref No. : ${controller.quotationModel.value.quotation?.orderRef ?? ""}",
                                  style: GoogleFonts.ptSans(
                                    fontSize: Get.height / 70,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color333,
                                  ),
                                ),
                                Text(
                                  "Date : ${formatDateFromString(controller.quotationModel.value.quotation?.quotationDate?.toString() ?? "")}",
                                  style: GoogleFonts.ptSans(
                                    fontSize: Get.height / 70,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.color333,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ).paddingOnly(
                            bottom: AppSize.displayHeight(context) * 0.02),
                        DynamicTable(
                          data: controller.quotationModel.value.quotationSub ??
                              [],
                          headers: const ["Product", "Qty", "Rate", "Amount"],
                          total: controller.quotationModel.value.quotationSub
                                  ?.fold(
                                      0.0,
                                      (previousValue, element) => previousValue + (double.parse(element.quotationSubAmount.toString())))
                                  .toString() ??
                              "0",
                        ),
                      ],
                    ),
                  )
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
                      text: "Edit Quotation",
                      onPressed: () {
                        Get.toNamed(RouteConstants.editQuotationView);
                      },
                    ),
                  ),
                  SizedBox(
                    width: AppSize.displayWidth(context) * 0.04,
                  ),
                  Expanded(
                    child: CommonButton(
                      padding: EdgeInsets.zero,
                      text: "Share Quotation",
                      onPressed: () async {
                        generateAndSharePDF(
                          context,
                          controller.quotationModel.value.quotationSub ?? [],
                          const ["Product", "Qty", "Rate", "Amount"],
                          controller.quotationModel.value.quotationSub
                                  ?.fold(
                                      0.0,
                                      (previousValue, element) =>
                                          previousValue +
                                          (double.parse(element.quotationSubAmount.toString())))
                                  .toString() ??
                              "0",
                        );
                      },
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
    String formattedDate = "${date.day} ${date.month} ${date.year}";
    return formattedDate;
  } catch (e) {
    return "";
  }
}
