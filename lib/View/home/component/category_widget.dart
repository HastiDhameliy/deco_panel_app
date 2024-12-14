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
  final bool isSelected; // Added parameter for selection state

  const CategoryItemWidget({
    super.key,
    this.networkImage,
    this.height,
    this.width,
    this.title,
    this.onTap,
    this.isSelected = false, // Default value for isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // Smooth animation
            height: isSelected
                ? height! * 1.2
                : height ?? AppSize.displayWidth(context) * 0.27,
            width: isSelected
                ? width! * 1.2
                : width ?? AppSize.displayWidth(context) * 0.27,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(defaultPadding / 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteColor,
              border: Border.all(
                color: isSelected ? AppColors.colorF45 : AppColors.buttonColor,
                // Change border color when selected
                width: isSelected ? 3 : 1, // Thicker border for selected state
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // Lighter shadow color
                  spreadRadius: 1, // Minimal spread for a subtle effect
                  blurRadius: 4, // Slight blur for softness
                  offset:
                      const Offset(0, 2), // Lower offset for a lighter shadow
                ),
                if (isSelected) // Add an extra shadow effect when selected
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
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
            color: isSelected
                ? AppColors.colorF45
                : AppColors.color333, // Change text color when selected
          ),
        ),
      ],
    );
  }
}
