import 'package:deco_flutter_app/Data/Services/product_api_service.dart';
import 'package:deco_flutter_app/Model/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/bottom_nav_controller.dart';
import '../../../Data/Providers/api_constants.dart';
import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_images.dart';
import '../../../Util/Constant/app_size.dart';
import '../../../widget/common_button.dart';
import '../../../widget/network_image_widget.dart';
import '../../../widget/quanity_picker.dart';
import '../../../widget/text_form_field_widget.dart';
import 'category_widget.dart';

class CategoryItemScreen extends GetView<BottomNavController> {
  const CategoryItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
          )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(controller.categoryData.value.productCategory ?? ""),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            controller.productCategoryModel.value.data != null &&
                    controller.productCategoryModel.value.data!.isNotEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          // Shadow color with opacity
                          spreadRadius: 2,
                          // Spread of the shadow
                          blurRadius: 6,
                          // Blur radius of the shadow
                          offset: const Offset(
                              0, 4), // Offset for the shadow (bottom only)
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSize.displayWidth(context) * 0.022,
                    ),
                    width: AppSize.displayWidth(context) * 0.23,
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          top: AppSize.displayHeight(context) * 0.01),
                      itemCount:
                          controller.productCategoryModel.value.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryItemWidget(
                          height: AppSize.displayWidth(context) * 0.17,
                          width: AppSize.displayWidth(context) * 0.17,
                          title: controller.productCategoryModel.value
                                  .data?[index].productCategory ??
                              "",
                          networkImage:
                              "${ApiConstants.imageBaseUrl}${controller.productCategoryModel.value.data?[index].productCategoryImage ?? ""}",
                          onTap: () {
                            controller.categoryData.value = controller
                                .productCategoryModel.value.data![index];
                            controller.getSubCategoryData(controller
                                    .productCategoryModel.value.data?[index].id
                                    .toString() ??
                                "");
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: AppSize.displayHeight(context) * 0.01,
                      ),
                    ))
                : const SizedBox(),
            SizedBox(
              width: AppSize.displayWidth(context) * 0.02,
            ),
            Obx(
              () => controller.subCategoryModel.value.data != null &&
                      controller.subCategoryModel.value.data!.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: AppSize.displayHeight(context) * 0.01),
                        shrinkWrap: true,
                        itemCount:
                            controller.subCategoryModel.value.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return subCategoryItem(
                            context: context,
                            title: controller.subCategoryModel.value
                                    .data?[index].productSubCategory ??
                                "",
                            image:
                                "${ApiConstants.imageBaseUrl}${controller.subCategoryModel.value.data?[index].productSubCategoryImage ?? ""}",
                            onTap: () async {
                              // Fetch product data
                              debugPrint(
                                  controller.categoryData.value.id.toString());
                              controller.getProductData(
                                context: context,
                                id: controller.categoryData.value.id
                                        ?.toString() ??
                                    "",
                                subId: controller
                                        .subCategoryModel.value.data?[index].id
                                        ?.toString() ??
                                    "",
                              );

                              // Wait for data to be fetched
                              await Future.delayed(const Duration(
                                  seconds: 1)); // Adjust this delay if needed

                              // Check if all three lists are populated
                              if (controller.brandList.isNotEmpty &&
                                  controller.thicknessList.isNotEmpty &&
                                  controller.sizeList.isNotEmpty &&
                                  controller.productItemList.isNotEmpty) {
                                // If the lists are populated, show the dialog
                                _showDialog(context);
                              } else {
                                // If any list is empty, show a toast or snackbar
                              }
                            },
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.6,
                            crossAxisCount: 2,
                            crossAxisSpacing:
                                AppSize.displayWidth(context) * 0.02,
                            mainAxisSpacing:
                                AppSize.displayHeight(context) * 0.015),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget subCategoryItem(
      {BuildContext? context,
      String? image,
      String? title,
      void Function()? onTap}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color with opacity
              spreadRadius: 2, // Spread of the shadow
              blurRadius: 6, // Blur radius of the shadow
              offset: const Offset(0, 4), // Offset for the shadow (bottom only)
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius))),
      padding: EdgeInsets.symmetric(
          vertical: AppSize.displayHeight(context) * 0.02,
          horizontal: AppSize.displayWidth(context) * 0.02),
      child: Column(
        children: [
          SizedBox(
            height: AppSize.displayHeight(context) * 0.12,
            child: CommonNetworkImage(
              imageUrl: image ?? "",
              placeholder: 'assets/images/loading_placeholder.png',
              errorPlaceholder: 'assets/images/error_image.png',
              fit: BoxFit.cover,
              fadeInDuration: const Duration(
                  milliseconds: 500), // Optional: Adjust fade duration
            ),
          ),
          SizedBox(
            height: AppSize.displayHeight(context) * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title ?? "Testing one1",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ptSans(
                      fontSize: Get.height * 0.018,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkHintColor),
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: onTap ??
                () {
                  // Add your click action here
                  debugPrint("Container clicked!");
                },
            borderRadius:
                BorderRadius.circular(AppSize.displayWidth(context) * 0.015),
            // Match the container radius
            splashColor: AppColors.buttonColor.withOpacity(0.2),
            // Ripple effect color
            highlightColor: AppColors.buttonColor.withOpacity(0.1),
            // Tap highlight
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: defaultPadding / 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(
                            AppSize.displayWidth(context) * 0.015)),
                        border: Border.all(color: AppColors.colorF45),
                        color: AppColors.colorF45.withOpacity(0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.orderListIcon,
                          height: Get.height * 0.02,
                          color: AppColors.colorF45,
                        ),
                        SizedBox(
                          width: Get.width / 50,
                        ),
                        Text(
                          "Order Now",
                          style: GoogleFonts.ptSans(
                            fontSize: Get.height / 65,
                            fontWeight: FontWeight.w700,
                            color: AppColors.colorF45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    debugPrint(controller.brandList.length.toString());

    showDialog(
      context: context,
      builder: (context) {
        return Obx(() => Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius / 2))),
                  width: AppSize.displayWidth(context),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey, // Use for form validation
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Filters',
                                  style: GoogleFonts.ptSans(
                                      fontSize:
                                          AppSize.displayHeight(context) * 0.02,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.color333),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: AppColors.color333),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                            _buildDropdownField<BrandData>(
                              context,
                              label: "Brand",
                              selectedValue: controller.selectedBrand,
                              items: controller.brandList
                                  .toSet()
                                  .map<DropdownMenuItem<BrandData>>(
                                    (BrandData e) =>
                                        DropdownMenuItem<BrandData>(
                                      value: e,
                                      child: Text(e.productsBrand ?? ""),
                                    ),
                                  )
                                  .toList()
                                  .obs,
                            ),
                            SizedBox(
                                height: AppSize.displayHeight(context) * 0.02),
                            _buildDropdownField<ThicknessData>(
                              context,
                              label: "Thickness",
                              selectedValue: controller.selectedThick,
                              items: controller.thicknessList
                                  .toSet()
                                  .map<DropdownMenuItem<ThicknessData>>(
                                    (ThicknessData e) =>
                                        DropdownMenuItem<ThicknessData>(
                                      value: e,
                                      child: Text(
                                          "${e.productsThickness?.toString() ?? ""} ${e.productsUnit?.toString() ?? ""}"),
                                    ),
                                  )
                                  .toList()
                                  .obs,
                            ),
                            SizedBox(
                                height: AppSize.displayHeight(context) * 0.02),
                            _buildDropdownField<SizeData>(
                              context,
                              label: "Size",
                              selectedValue: controller.selectedSize,
                              items: controller.sizeList
                                  .toSet()
                                  .map<DropdownMenuItem<SizeData>>(
                                    (SizeData e) => DropdownMenuItem<SizeData>(
                                      value: e,
                                      child: Text(
                                          "${e.productsSize1?.toString() ?? ""}*${e.productsSize2?.toString() ?? ""} ${e.productsSizeUnit?.toString() ?? ""}"),
                                    ),
                                  )
                                  .toList()
                                  .obs,
                            ),
                            SizedBox(
                                height: AppSize.displayHeight(context) * 0.02),
                            QuantityPicker(
                              initialQuantity: controller.qty.value,
                              minQuantity: 1,
                              maxQuantity: 10,
                              labelText: "Quantity",
                              onQuantityChanged: (quantity) {
                                controller.qty.value = quantity;
                                debugPrint("Selected quantity: $quantity");
                              },
                            ),
                            SizedBox(
                                height: AppSize.displayHeight(context) * 0.025),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CommonButton(
                                    boxShadowColor: Colors.transparent,
                                    enabledColor: AppColors.whiteColor,
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: Get.height / 65,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.colorB5B,
                                    ),
                                    text: "Cancel",
                                    isLoading: controller.isLoadingCCart.value,
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        AppSize.displayWidth(context) * 0.02),
                                Expanded(
                                  child: CommonButton(
                                    text: "ADD TO CART",
                                    isLoading: controller.isLoadingCCart.value,
                                    onPressed: () async {
                                      await ProductApiService()
                                          .createCartApiUrl(
                                        context: context,
                                        id: controller.productItemList.first
                                                .productsCatgId
                                                ?.toString() ??
                                            "",
                                        brand: controller.productItemList.first
                                                .productsBrand
                                                ?.toString() ??
                                            "",
                                        loading: controller.isLoadingCCart,
                                        qty: controller.qty.value.toString(),
                                        size1: controller.productItemList.first
                                                .productsSize1
                                                ?.toString() ??
                                            "",
                                        size2: controller.productItemList.first
                                                .productsSize2
                                                ?.toString() ??
                                            "",
                                        sizeUnit: controller.productItemList
                                                .first.productsSizeUnit
                                                ?.toString() ??
                                            "",
                                        subId: controller.productItemList.first
                                                .productsSubCatgId
                                                ?.toString() ??
                                            "",
                                        thickness: controller.productItemList
                                                .first.productsThickness
                                                ?.toString() ??
                                            "",
                                        unit: controller.productItemList.first
                                                .productsUnit
                                                ?.toString() ??
                                            "",
                                      );
                                      Get.back();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: AppSize.displayHeight(context) * 0.01),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }

  Widget _buildDropdownField<T>(
    BuildContext context, {
    required String label,
    required RxList<DropdownMenuItem<T>>
        items, // Generic type for dropdown items
    required Rx<T> selectedValue, // Reactive selected value of type T
    String hintText = "Select an option", // Default hint text
  }) {
    // Ensure selectedValue exists in the list
    bool valueExists = items.any((item) => item.value == selectedValue.value);

    // If the selected value doesn't exist in the list, set a default value (like null or the first item)
    if (!valueExists) {
      selectedValue.value = (items.isNotEmpty ? items.first.value : null as T)
          as T; // Set default or null
    }

    // Remove duplicates by converting the list to a set, then back to a list
    var uniqueItems = items.toSet().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align label and dropdown
      children: [
        Text(
          label,
          style: GoogleFonts.ptSans(
              fontSize: AppSize.displayHeight(context) * 0.017,
              fontWeight: FontWeight.w700,
              color: AppColors.colorB5B),
          // Customize the label style
        ),
        const SizedBox(height: 8), // Spacing between label and dropdown
        Obx(
          () => CommonDropdownField<T>(
            items: uniqueItems, // Pass unique items to avoid duplicates
            value: selectedValue.value, // Bind the selected value
            hintText: hintText, // Pass the hint text
            onChanged: (T? value) {
              if (value != null) {
                selectedValue.value = value; // Update the reactive value
              }
            },
          ),
        ),
      ],
    );
  }
}