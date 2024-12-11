import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/past_order_controller.dart';

class OrderListScreen extends GetView<PastOrderController> {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
      bottomSheet: Container(
        height: AppSize.displayHeight(context) * 0.08,
        color: Colors.white,
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
                      enabledColor: AppColors.hintColor2,
                      text: "Add Items",
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: AppSize.displayWidth(context) * 0.04,
                  ),
                  Expanded(
                    child: CommonButton(
                      padding: EdgeInsets.zero,
                      enabledColor: AppColors.buttonColor,
                      text: "Get Quotation",
                      onPressed: () {},
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
