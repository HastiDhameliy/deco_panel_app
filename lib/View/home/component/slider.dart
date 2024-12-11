import 'package:carousel_slider/carousel_slider.dart';
import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/bottom_nav_controller.dart';
import '../../../Data/Providers/api_constants.dart';
import '../../../widget/network_image_widget.dart';
import 'best_seller_widget.dart';

class AnimatedCarousel extends StatelessWidget {
  AnimatedCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => controller.sliderModel.value.sliderbanner != null &&
                controller.sliderModel.value.sliderbanner!.isNotEmpty
            ? Column(
                children: [
                  CarouselSlider.builder(
                    itemCount:
                        controller.sliderModel.value.sliderbanner!.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        MyCard(
                      imageUrl: ApiConstants.imageBaseUrl +
                          controller.sliderModel.value.sliderbanner![itemIndex]
                              .sliderImage!,
                    ),
                    options: CarouselOptions(
                      height: AppSize.displayHeight(context) * 0.2,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        controller.currentSliderIndex.value = index;
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: AppSize.displayHeight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.sliderModel.value.sliderbanner!.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: controller.currentSliderIndex.value == index
                            ? 8.0
                            : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: controller.currentSliderIndex.value == index
                              ? AppColors.color333
                              : AppColors.colorCBC,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox()),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final String? imageUrl;

  const MyCard({this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.displayHeight(context) * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CommonNetworkImage(
          imageUrl: imageUrl ?? "",
          placeholder: 'assets/images/loading_placeholder.png',
          errorPlaceholder: 'assets/images/error_image.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class OfferCarousel extends GetView<BottomNavController> {
  const OfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.offerBannerList.isNotEmpty
        ? SizedBox(
            height: AppSize.displayHeight(context) * 0.16,
            child: PageView.builder(
              onPageChanged: (value) {}, // Update the page index
              itemCount: controller.offerBannerList.length,
              itemBuilder: (context, index) {
                return BestSellerWidget(
                  networkImage:
                      "${ApiConstants.imageBaseUrl}${controller.offerBannerList[index].offerImage ?? ""}",
                  title: controller.offerBannerList[index].offerHeading,
                );
              },
            ),
          )
        : const SizedBox());
  }
}
