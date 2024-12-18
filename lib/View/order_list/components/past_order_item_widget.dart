import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/past_order_controller.dart';
import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_size.dart';
import '../../../widget/network_image_widget.dart';

enum OrderType { orderList, pastOrder }

class PastOrderItem extends GetView<PastOrderController> {
  final String? title;
  final String? networkImage;
  final String? subTitle;
  final String? size;
  final String? thickness;
  final String? brand;
  final Widget? orderWidget;
  final Widget? statusWidget;
  final int? initialValue;
  final int? initialQuo;
  final Function(int)? onQtyValueChanged;
  final Function(int)? onQty2ValueChanged;
  final RxBool? value;
  final void Function(bool?)? onChanged;
  final void Function()? onDeletePressed;
  final void Function()? onTap;

  const PastOrderItem(
      {super.key,
      this.title,
      this.onTap,
      this.initialValue,
      this.initialQuo,
      this.onQtyValueChanged,
      this.onQty2ValueChanged,
      this.orderWidget,
      this.subTitle,
      this.statusWidget,
      this.size,
      this.thickness,
      this.brand,
      this.onDeletePressed,
      this.networkImage,
      this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: AppColors.bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*if (orderWidget == null)
                  Obx(
                    () => CheckboxTheme(
                      data: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        side: const BorderSide(
                          color: Colors.grey,
                          // Border color for both active and inactive
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Checkbox(
                        value: value?.value ?? true,
                        onChanged: onChanged,
                        fillColor:
                            const MaterialStatePropertyAll(Colors.transparent),

                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.grey, // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        side: const BorderSide(
                          color: Colors.grey, // Border color
                          width: 2.0, // Border width
                        ),
                        checkColor: AppColors.colorF45,
                        // Check icon color
                        activeColor:
                            AppColors.colorF45, // Background color when checked
                      ),
                    ),
                  ),*/
                SizedBox(
                  height: AppSize.displayHeight(context) * 0.11,
                  width: AppSize.displayHeight(context) * 0.11,
                  child: CommonNetworkImage(
                    imageUrl: networkImage ?? "",
                    placeholder: 'assets/images/loading_placeholder.png',
                    errorPlaceholder: 'assets/images/error_image.png',
                    fit: BoxFit.fill,
                    fadeInDuration: const Duration(milliseconds: 500),
                  ),
                ),
                SizedBox(
                  width: AppSize.displayWidth(context) * 0.035,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              title ?? "",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.ptSans(
                                fontSize: Get.height / 55,
                                fontWeight: FontWeight.w700,
                                color: AppColors.color333,
                              ),
                            ),
                          ),
                        ],
                      ),
                      orderWidget ??
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonTextWidget(
                                context: context,
                                title: "Size",
                                subTitle: size,
                              ),
                              commonTextWidget(
                                context: context,
                                title: "Brand",
                                subTitle: brand,
                              ),
                              commonTextWidget(
                                context: context,
                                title: "Thickness",
                                subTitle: thickness,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  PlusMinusContainer(
                                    initialValue: initialValue!,
                                    onValueChanged:
                                        onQtyValueChanged ?? (p0) {},
                                  ),
                                  if (initialQuo != null)
                                    PlusMinusContainer(
                                      initialValue: initialQuo!,
                                      onValueChanged:
                                          onQty2ValueChanged ?? (p0) {},
                                    ).paddingOnly(
                                        left: AppSize.displayWidth(context) *
                                            0.04)
                                  else if (initialQuo == null) ...[
                                    const Spacer(),
                                    IconButton(
                                      onPressed: onDeletePressed ?? () {},
                                      icon: Image.asset(
                                        AppImages.deleteIcon,
                                        height: AppSize.displayHeight(context) *
                                            0.022,
                                      ),
                                    ),
                                  ]
                                ],
                              ).paddingOnly(
                                  top: AppSize.displayHeight(context) * 0.01),
                            ],
                          )
                    ],
                  ),
                ),
                if (statusWidget != null) statusWidget!
              ],
            ),
            const Divider(
              color: AppColors.colorDDD,
            )
          ],
        ),
      ),
    );
  }
}

class PlusMinusContainer extends StatefulWidget {
  final int initialValue;
  final Function(int) onValueChanged;

  const PlusMinusContainer({
    super.key,
    this.initialValue = 1, // Default value set to 1
    required this.onValueChanged,
  });

  @override
  PlusMinusContainerState createState() => PlusMinusContainerState();
}

class PlusMinusContainerState extends State<PlusMinusContainer> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _currentValue++;
    });
    widget.onValueChanged(_currentValue);
  }

  void _decrement() {
    if (_currentValue > 1) {
      setState(() {
        _currentValue--;
      });
      widget.onValueChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding / 2,
          vertical: AppSize.displayHeight(context) * 0.002),
      decoration: BoxDecoration(
        color: AppColors.color6F6,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(defaultRadius * 10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: _currentValue > 1 ? _decrement : null,
            child: Icon(
              Icons.remove,
              color: _currentValue > 1
                  ? AppColors.textBlack
                  : Colors.grey, // Change color to indicate disabled
              size: AppSize.displayHeight(context) * 0.02,
            ),
          ),
          SizedBox(
            width: AppSize.displayWidth(context) * 0.03,
          ),
          Text(
            _currentValue.toString(),
            style: GoogleFonts.ptSans(
              fontSize: Get.height / 65,
              fontWeight: FontWeight.w700,
              color: AppColors.color333,
            ),
          ),
          SizedBox(
            width: AppSize.displayWidth(context) * 0.03,
          ),
          InkWell(
            onTap: _increment,
            child: Icon(
              Icons.add,
              color: AppColors.textBlack,
              size: AppSize.displayHeight(context) * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}

Widget statusWidget({
  required BuildContext context,
  required String statusTitle,
}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: AppSize.displayWidth(context) * 0.05,
        vertical: AppSize.displayHeight(context) * 0.002),
    decoration: const BoxDecoration(
        color: AppColors.colorC1F,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius / 5))),
    child: Text(
      statusTitle,
      style: GoogleFonts.ptSans(
        fontSize: Get.height / 65,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
    ),
  );
}

Widget pastOrderWidget(
    {BuildContext? context,
    String? orderDate,
    String? orderNumber,
    String? royaltyPoint}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: AppSize.displayHeight(context) * 0.002,
      ),
      Text(
        "Order Date: ${formatDateFromString(orderDate ?? "")}",
        style: GoogleFonts.ptSans(
          fontSize: Get.height / 65,
          fontWeight: FontWeight.w400,
          color: AppColors.color333,
        ),
      ),
      Text(
        "Order Number: ${orderNumber ?? ""}",
        style: GoogleFonts.ptSans(
          fontSize: Get.height / 65,
          fontWeight: FontWeight.w400,
          color: AppColors.color333,
        ),
      ),
      Row(
        children: [
          Container(
            height: AppSize.displayHeight(context) * 0.033,
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.displayWidth(context) * 0.04),
            decoration: BoxDecoration(
              color: AppColors.color419.withOpacity(0.25),
              borderRadius: const BorderRadius.all(
                Radius.circular(defaultRadius / 5),
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImages.tokenIcon,
                  height: AppSize.displayHeight(context) * 0.022,
                ).paddingOnly(bottom: AppSize.displayHeight(context) * 0.004),
                SizedBox(
                  width: AppSize.displayWidth(context) * 0.02,
                ),
                Text(
                  "Royalty Points",
                  style: GoogleFonts.ptSans(
                    fontSize: Get.height / 65,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color333,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
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
          fontSize: Get.height / 65,
          fontWeight: FontWeight.w400,
        ),
      ),
      Expanded(
        flex: 8,
        child: Text(
          subTitle ?? "",
          textAlign: TextAlign.start,
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 65,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
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
    String formattedDate = "${date.day} ${months[date.month - 1]} ${date.year}";
    return formattedDate;
  } catch (e) {
    return "";
  }
}
