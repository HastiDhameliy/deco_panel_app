import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_size.dart';
import '../../../widget/network_image_widget.dart';

class PastOrderItem extends StatelessWidget {
  final String? title;
  final String? networkImage;
  final String? subTitle;

  const PastOrderItem(
      {super.key, this.title, this.subTitle, this.networkImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: AppSize.displayWidth(context) * 0.035,
            ),
            Container(
              height: AppSize.displayHeight(context) * 0.11,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(defaultRadius)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        title ?? "",
                        style: GoogleFonts.ptSans(
                          fontSize: Get.height / 55,
                          fontWeight: FontWeight.w700,
                          color: AppColors.color333,
                        ),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      PlusMinusContainer(
                        onValueChanged: (int) {},
                      ),
                      const Spacer(),
                      Image.asset(
                        AppImages.deleteIcon,
                        height: AppSize.displayHeight(context) * 0.025,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: AppColors.colorDDD,
        )
      ],
    );
  }
}

class PlusMinusContainer extends StatefulWidget {
  final int initialValue;
  final Function(int) onValueChanged;

  const PlusMinusContainer({
    super.key,
    this.initialValue = 0,
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
    setState(() {
      if (_currentValue > 0) _currentValue--;
    });
    widget.onValueChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quantity",
          style: GoogleFonts.ptSans(
            fontSize: Get.height / 65,
            fontWeight: FontWeight.w400,
            color: AppColors.color333,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: AppSize.displayHeight(context) * 0.005),
          decoration: BoxDecoration(
            color: AppColors.color6F6,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(defaultRadius * 10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _increment,
                child: Icon(
                  Icons.add,
                  color: AppColors.textBlack,
                  size: AppSize.displayHeight(context) * 0.02,
                ),
              ),
              SizedBox(
                width: AppSize.displayWidth(context) * 0.035,
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
                width: AppSize.displayWidth(context) * 0.035,
              ),
              InkWell(
                onTap: _decrement,
                child: Icon(
                  Icons.remove,
                  color: AppColors.textBlack,
                  size: AppSize.displayHeight(context) * 0.02,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
