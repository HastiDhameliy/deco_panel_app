import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Util/Constant/app_colors.dart';
import '../../../widget/network_image_widget.dart';

class BestSellerWidget extends StatelessWidget {
  final String? networkImage;
  final String? title;
  final String? url;

  const BestSellerWidget({super.key, this.networkImage, this.title, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding / 1.5, vertical: defaultPadding / 1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
            Radius.circular(AppSize.displayWidth(context) * 0.02)),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorF45.withOpacity(0.1), // Light shadow color
            offset: const Offset(0, 4), // Horizontal and vertical offset
            blurRadius: 6, // Softness of the shadow
            spreadRadius: 1, // How much the shadow expands
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: AppSize.displayHeight(context) * 0.11,
            width: AppSize.displayHeight(context) * 0.11,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSize.displayWidth(context) * 0.02)),
              child: CommonNetworkImage(
                imageUrl: networkImage ?? "",
                placeholder: 'assets/images/loading_placeholder.png',
                errorPlaceholder: 'assets/images/error_image.png',
                fit: BoxFit.fill,
                fadeInDuration: const Duration(
                    milliseconds: 500), // Optional: Adjust fade duration
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title ?? "",
                      style: GoogleFonts.ptSans(
                        fontSize: Get.height / 48,
                        fontWeight: FontWeight.w700,
                        color: AppColors.color333,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    children: [
                      url == "null"
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                launchUrl(
                                  Uri.parse(
                                    url.toString(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding,
                                    vertical: defaultPadding / 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      AppSize.displayWidth(context) * 0.015,
                                    ),
                                  ),
                                  border: Border.all(color: AppColors.colorF45),
                                  color: AppColors.colorF45.withOpacity(0.2),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppImages.orderListIcon,
                                      height: Get.height * 0.022,
                                      color: AppColors.colorF45,
                                    ),
                                    SizedBox(
                                      width: Get.width / 50,
                                    ),
                                    Text(
                                      "Order Now",
                                      style: GoogleFonts.ptSans(
                                        fontSize: Get.height / 60,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.colorF45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget getOrderNow(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding, vertical: defaultPadding / 4),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
            Radius.circular(AppSize.displayWidth(context) * 0.015)),
        border: Border.all(color: AppColors.colorF45),
        color: AppColors.colorF45.withOpacity(0.2)),
    child: Row(
      children: [
        Image.asset(
          AppImages.orderListIcon,
          height: Get.height * 0.022,
          color: AppColors.colorF45,
        ),
        SizedBox(
          width: Get.width / 50,
        ),
        Text(
          "Order Now",
          style: GoogleFonts.ptSans(
            fontSize: Get.height / 60,
            fontWeight: FontWeight.w700,
            color: AppColors.colorF45,
          ),
        ),
      ],
    ),
  );
}
