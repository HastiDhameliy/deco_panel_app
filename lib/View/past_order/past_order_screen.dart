import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/past_order_controller.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';
import 'components/past_order_item_widget.dart';

class PastOrderScreen extends GetView<PastOrderController> {
  const PastOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Column(
            children: [
              TabBar(
                controller: controller.tabController.value,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                onTap: (value) {
                  controller.tapIndex.value = value;
                },
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: AppColors.buttonColor, // Line color
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
                              : AppColors.hintColor.withOpacity(0.1),
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade700),
                            right: BorderSide(color: Colors.grey.shade700),
                            bottom: BorderSide(
                                color: controller.tapIndex.value != 0
                                    ? Colors.grey.shade700
                                    : Colors.transparent // Border for square
                                ),
                          ),
                        ),
                        child: const Text("Current Order"),
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
                              : AppColors.hintColor.withOpacity(0.1),
                          border: Border(
                            top: BorderSide(color: Colors.grey.shade700),
                            right: BorderSide(color: Colors.grey.shade700),
                            bottom: BorderSide(
                                color: controller.tapIndex.value != 1
                                    ? Colors.grey.shade700
                                    : Colors.transparent),
                            left: BorderSide(color: Colors.grey.shade700),
                          ), // Border for square
                        ),
                        child: const Text("Past Order"),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController.value,
                  children: [
                    ListView.separated(
                        itemBuilder: (context, index) {
                          return PastOrderItem(
                            networkImage:
                                "https://s3-alpha-sig.figma.com/img/954b/b39c/f13bbae3b03403cf5d9260278a2657e4?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=igtr5z9yMekmsIiCD4NGblY6d0IXmebiD3XUJ~322sSL0VQIU5j6HSn0A7cU3CYFkG1p9XG7qzQY7EdacpjV1rSxcmLnpVlHAjo87Hww69Pazaje2bn2lQoRVjpkBL59B-3tS4-pJ7IGi14k5jOtXXqGEe1awt2KTeTiWGPnDyM~BnqmRZuLiGsL6eDG2x4-jP4~GUQZFUaBVKb5xRuXfetx9zgK4ldg8JlppD0Fu5ThNrXhPyYZmOWqziwJ3Figa97R5vmCHBDQVDHvOHRnRsVKCIxRTij2d~Pzrpfm4x1CStAIeAioST7Doo2LaLxQiZlzQkAzKXFt29h~xjKbng__",
                            title: "hjhddj",
                            subTitle: "hhdhasj",
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: 20),
                    Center(
                      child: Text(
                        'Past Order Content',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
