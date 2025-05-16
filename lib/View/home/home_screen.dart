import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controller/bottom_nav_controller.dart';
import '../../Data/Providers/api_constants.dart';
import '../../Data/Providers/session_manager.dart';
import '../../RoutesManagment/routes.dart';
import '../../Util/Constant/app_colors.dart';
import '../../Util/Constant/app_size.dart';
import '../../Util/custom/custom_toast.dart';
import 'component/category_widget.dart';
import 'component/slider.dart';

class HomeScreen extends GetView<BottomNavController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    const AnimatedCarousel(),
                    SizedBox(
                      height: Get.height / 50,
                    ),
                    Text(
                      "Category",
                      style: GoogleFonts.ptSans(
                        fontSize: Get.height / 50,
                        fontWeight: FontWeight.w700,
                        color: AppColors.color333,
                      ),
                    ).paddingOnly(left: defaultPadding / 1.2),
                    controller.productCategoryModel.value.data != null &&
                            controller
                                .productCategoryModel.value.data!.isNotEmpty
                        ? GridView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 1.5,
                                vertical: defaultPadding),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller
                                .productCategoryModel.value.data?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.82,
                                    crossAxisCount: 3,
                                    crossAxisSpacing:
                                        AppSize.displayWidth(context) * 0.03,
                                    mainAxisSpacing:
                                        AppSize.displayHeight(context) * 0.015),
                            itemBuilder: (BuildContext context, int index) {
                              return CategoryItemWidget(
                                title: controller.productCategoryModel.value
                                        .data?[index].productCategory ??
                                    "",
                                networkImage:
                                    "${ApiConstants.imageBaseUrl}${controller.productCategoryModel.value.data?[index].productCategoryImage ?? ""}",
                                onTap: () {
                                  controller.categoryData.value = controller
                                      .productCategoryModel.value.data![index];
                                  controller.getSubCategoryData(controller
                                          .productCategoryModel
                                          .value
                                          .data?[index]
                                          .id
                                          .toString() ??
                                      "");

                                  Get.toNamed(RouteConstants.categoryItemScreen,
                                      arguments: {
                                        "category_name": controller
                                                .productCategoryModel
                                                .value
                                                .data?[index]
                                                .productCategory ??
                                            ""
                                      });
                                },
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Text(
                "Best Seller",
                style: GoogleFonts.ptSans(
                  fontSize: Get.height / 50,
                  fontWeight: FontWeight.w700,
                  color: AppColors.color333,
                ),
              ).paddingOnly(
                  top: defaultPadding / 1.2, left: defaultPadding / 1.2),
              const OfferCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> postDeleteProfileApi(BuildContext context) async {
  try {
    final token = (await SessionManager().getAuthToken()) ?? "";
    print(Uri.parse(ApiConstants.deleteProfile));
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiConstants.deleteProfile),
    );

    request.headers.addAll({
      'Authorization': token,
    });

    final res = await request.send();
    final responseDone = await http.Response.fromStream(res);
    final responseData = json.decode(responseDone.body);
    debugPrint("Post delete profile response: $responseData");
    if (responseDone.statusCode == 200) {
      if (responseData['code'] == 200) {
        customToast(context, responseData['msg'] ?? "Deleted successfully",
            ToastType.success);

        await SessionManager().clearSharedPreferences();
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Get.offAllNamed(RouteConstants.loginScreen);
      } else {
        customToast(context, responseData['msg'] ?? "Something went wrong",
            ToastType.warning);
      }
    } else {
      customToast(context, "Something went wrong", ToastType.warning);
    }
  } catch (e) {
    customToast(context, "Something went wrong", ToastType.warning);
    debugPrint("Error deleting profile: $e");
  }
}
