import 'package:deco_flutter_app/Controller/feedback_controller.dart';
import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Util/Constant/app_colors.dart';

class AboutUsScreen extends GetView<FeedbackController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.black.withOpacity(0.1), // Light shadow color
              blurRadius: 10.0, // Soften the shadow
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
        title: Text(
          "About Us",
          style: GoogleFonts.roboto(
            color: AppColors.color333,
            fontSize: Get.height / 35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSize.displayHeight(context) * 0.02,
            horizontal: AppSize.displayWidth(context) * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              AppImages.logo,
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            /* Container(
              height: AppSize.displayHeight(context) * 0.14,
              // Height of the container
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.aboutUsBg),
                  fit: BoxFit
                      .fill, // Ensures the background covers the container
                ),
              ),
              child: Center(
                child: Image.asset(
                  AppImages.panelImage,
                  fit: BoxFit.cover,
                  // Adjust to fill the available space proportionally
                  width: double.infinity,
                  // Ensures it stretches horizontally
                  height: double.infinity, // Ensures it stretches vertically
                ),
              ),
            ),*/
            Text(
              "Deco Panel",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color: AppColors.darkHintColor,
                fontSize: Get.height / 45,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Tag line here",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color: AppColors.hintColor2,
                fontSize: Get.height / 60,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: AppSize.displayHeight(context) * 0.02,
            ),
            commonAboutUsWidget(
              title: "8867171060",
              imageIconData: Icons.call_rounded,
              isIcon: true,
              context: context,
            ),
            commonAboutUsWidget(
              title: "info@decopanel.in",
              imageIconData: Icons.email_outlined,
              isIcon: true,
              context: context,
            ),
            commonAboutUsWidget(
              title: "www.decopanel.com",
              imageIconData: Icons.public,
              isIcon: true,
              context: context,
            ),
            commonAboutUsWidget(
              title: "www.google.com",
              imageIconData: Icons.location_on_outlined,
              isIcon: true,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget commonAboutUsWidget(
      {bool isIcon = false,
      String? title,
      dynamic imageIconData,
      BuildContext? context}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: AppSize.displayHeight(context) * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                !isIcon
                    ? Image.asset(imageIconData)
                    : Icon(
                        imageIconData,
                        color: AppColors.buttonColor,
                        size: AppSize.displayHeight(context) * 0.045,
                      ),
              ],
            ),
          ),
          SizedBox(
            width: AppSize.displayWidth(context) * 0.04,
          ),
          Expanded(
            flex: 4,
            child: Text(
              title ?? "",
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color: AppColors.hintColor2,
                fontSize: Get.height / 50,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PeanutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start at the left-middle edge
    path.moveTo(0, size.height / 2);

    // Top-left bulge
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.1, // Control point for top-left curve
      size.width / 2, size.height * 0.2, // Endpoint for top-center
    );

    // Top-right bulge
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.1, // Control point for top-right curve
      size.width, size.height / 2, // Endpoint at the right-middle
    );

    // Bottom-right bulge
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.9,
      // Control point for bottom-right curve
      size.width / 2, size.height * 0.8, // Endpoint for bottom-center
    );

    // Bottom-left bulge
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.9,
      // Control point for bottom-left curve
      0, size.height / 2, // Endpoint back to the left-middle
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
