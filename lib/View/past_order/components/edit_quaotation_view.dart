import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/past_order_controller.dart';
import '../../../Data/Providers/api_constants.dart';
import '../../order_list/components/past_order_item_widget.dart';

class EditQuotationView extends GetView<PastOrderController> {
  const EditQuotationView({super.key});

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
          "Edit Quotation",
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => controller
                .quotationModel.value.quotationSub!.isNotEmpty
            ? ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: defaultPadding),
                    itemBuilder: (context, index) {
                      return PastOrderItem(
                        size:
                            "${controller.quotationModel.value.quotationSub![index].quotationSubSize1 ?? ""}*${controller.quotationModel.value.quotationSub![index].quotationSubSize2 ?? ""} ${controller.quotationModel.value.quotationSub![index].quotationSubSizeUnit ?? ""}",
                        brand: controller.quotationModel.value
                                .quotationSub![index].quotationSubBrand ??
                            "",
                        thickness:
                            "${controller.quotationModel.value.quotationSub![index].quotationSubThickness ?? ""} ${controller.quotationModel.value.quotationSub![index].quotationSubUnit ?? ""}",
                        onDeletePressed: () {
                          deleteDialog(
                            context: context,
                            onPressed: () async {
                              await controller.deleteCartItemApi(
                                  context,
                                  controller.quotationModel.value
                                          .quotationSub![index].id
                                          ?.toString() ??
                                      "");
                              controller.quotationModel.value.quotationSub!
                                  .removeAt(index);
                              Get.back();
                            },
                          );
                        },
                        initialQuo: controller.quotationModel.value
                            .quotationSub![index].quotationSubAmount,
                        initialValue: controller.quotationModel.value
                            .quotationSub![index].quotationSubQuantity,
                        onQtyValueChanged: (val) async {},
                        onQty2ValueChanged: (val) async {},
                        networkImage:
                            "${ApiConstants.imageBaseUrl}${controller.quotationModel.value.quotationSub![index].productCategoryImage?.toString() ?? ""}",
                        title: controller.quotationModel.value
                                .quotationSub![index].quotationSubBrand
                                ?.toString() ??
                            "",
                        subTitle: controller.quotationModel.value
                                .quotationSub![index].quotationSubProductId
                                ?.toString() ??
                            "",
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount:
                        controller.quotationModel.value.quotationSub!.length)
                .paddingOnly(bottom: AppSize.displayHeight(context) * 0.05)
            : const SizedBox()),
      ),
      bottomSheet: Container(
        height: AppSize.displayHeight(context) * 0.12,
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding * 1.5),
        color: AppColors.bgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonButton(
              text: "Update Quotation",
              isEnabled:
                  controller.quotationModel.value.quotationSub!.isNotEmpty,
              isLoading: controller.updateQuoLoading.value,
              onPressed: () async {
                /* for (var item
                    in controller.quotationModel.value.quotationSub!) {
                  await OrderApiService().updateQuotationApiUrl(
                      loading: controller.updateQuoLoading,
                      isDone: ,
                      context: context,
                      orderref:
                          controller.quotationModel.value.quotation?.orderRef ??
                              "",
                      quotationSubQuantity:
                          item.quotationSubQuantity?.toString() ?? "",
                      quotationSubRate:
                          item.quotationSubAmount?.toString() ?? "",
                      quotationSubProductId:
                          item.quotationSubProductId?.toString() ?? "",
                      id: item.id?.toString() ?? "");
                }
                controller.updateQuoLoading.value = false;*/
              },
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
