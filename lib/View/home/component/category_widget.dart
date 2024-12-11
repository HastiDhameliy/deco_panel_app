import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Util/Constant/app_colors.dart';
import '../../../widget/network_image_widget.dart';

class CategoryItemWidget extends StatelessWidget {
  final String? networkImage;
  final String? title;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const CategoryItemWidget(
      {super.key,
      this.networkImage,
      this.height,
      this.width,
      this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: height ?? AppSize.displayWidth(context) * 0.27,
            width: width ?? AppSize.displayWidth(context) * 0.27,
            padding: const EdgeInsets.all(defaultPadding / 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.buttonColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // Lighter shadow color
                  spreadRadius: 1, // Minimal spread for a subtle effect
                  blurRadius: 4, // Slight blur for softness
                  offset:
                      const Offset(0, 2), // Lower offset for a lighter shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.displayWidth(context) * 0.3),
              ),
              child: CommonNetworkImage(
                imageUrl: networkImage ?? "",
                placeholder: 'assets/images/loading_placeholder.png',
                errorPlaceholder: 'assets/images/error_image.png',
                fit: BoxFit.fill,
                fadeInDuration: const Duration(milliseconds: 500),
              ),
            ),
          ),
        ).paddingOnly(bottom: AppSize.displayWidth(context) * 0.02),
        Text(
          title ?? "",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.ptSans(
            fontSize: Get.height / 65,
            fontWeight: FontWeight.w700,
            color: AppColors.color333,
          ),
        ),
      ],
    );
  }
}
