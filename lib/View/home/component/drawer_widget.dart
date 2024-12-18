import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/bottom_nav_controller.dart';
import '../../../Controller/profile_controller.dart';
import '../../../Data/Services/api_service.dart';
import '../../../RoutesManagment/routes.dart';
import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_images.dart';
import '../../../Util/Constant/app_size.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List drawerItem = [
    if (userType == 1) {1: "Home", 2: AppImages.homeIcon},
    {1: "Profile", 2: AppImages.profileIcon},
    {1: "Order List ", 2: AppImages.orderListIcon},
    {1: "Reward Points", 2: AppImages.pastOrdersIcon},
    {1: "Feedback", 2: AppImages.feedbackIcon},
    {1: "About Us", 2: AppImages.aboutUsIconIcon},
    {1: "Logout", 2: AppImages.logoutIcon},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Obx(
            () => Column(
              children: [
                SizedBox(
                  height: AppSize.displayHeight(context) * 0.06,
                ),
                Container(
                  height: AppSize.displayWidth(context) * 0.3,
                  width: AppSize.displayWidth(context) * 0.3,
                  padding: const EdgeInsets.all(defaultPadding / 4),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          AppImages.panelImage,
                        ),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  Get.find<ProfileController>()
                          .useDataModel
                          .value
                          .data
                          ?.fullName ??
                      "",
                  style: GoogleFonts.ptSans(
                    color: AppColors.darkHintColor,
                    fontSize: Get.height / 45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  Get.find<ProfileController>()
                          .useDataModel
                          .value
                          .data
                          ?.email ??
                      "",
                  style: GoogleFonts.roboto(
                    color: AppColors.darkHintColor,
                    fontSize: Get.height / 65,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.buttonColor,
          ),
          ...List.generate(
            drawerItem.length,
            (index) => ListTile(
              leading: Image.asset(
                drawerItem[index][2],
                color: AppColors.buttonColor,
                height: index == 5
                    ? AppSize.displayHeight(context) * 0.022
                    : index == 6
                        ? AppSize.displayHeight(context) * 0.03
                        : AppSize.displayHeight(context) * 0.027,
              ),
              title: Text(
                drawerItem[index][1],
                style: GoogleFonts.ptSans(
                  fontSize: Get.height / 55,
                  fontWeight: FontWeight.w400,
                  color: AppColors.buttonColor,
                ),
              ),
              onTap: () async {
                var con = Get.find<BottomNavController>();
                if (userType == 1) {
                  switch (index) {
                    case 0:
                      con.drawerKey.currentState?.closeDrawer();
                      con.changeIndex(0);
                      break;
                    case 1:
                      con.drawerKey.currentState?.closeDrawer();
                      con.changeIndex(3);
                      break;
                    case 2:
                      con.drawerKey.currentState?.closeDrawer();
                      con.changeIndex(2);
                      break;
                    case 3:
                      Get.toNamed(RouteConstants.rewardPoint);
                      break;
                    case 5:
                      Get.toNamed(RouteConstants.aboutUsScreen);
                      break;
                    case 4:
                      Get.toNamed(RouteConstants.feedBackScreen);
                      break;
                    case 6:
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Get.offAllNamed(RouteConstants.loginScreen);
                      break;
                    default:
                  }
                } else {
                  switch (index) {
                    case 0:
                      con.drawerKey.currentState?.closeDrawer();
                      con.changeIndex(1);
                      break;
                    case 1:
                      con.drawerKey.currentState?.closeDrawer();
                      con.changeIndex(0);
                      break;
                    case 2:
                      Get.toNamed(RouteConstants.rewardPoint);
                      break;
                    case 4:
                      Get.toNamed(RouteConstants.aboutUsScreen);
                      break;
                    case 3:
                      Get.toNamed(RouteConstants.feedBackScreen);
                      break;
                    case 5:
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Get.offAllNamed(RouteConstants.loginScreen);
                      break;
                    default:
                  }
                }
                // Handle Home action
              },
            ),
          )
        ],
      ),
    );
  }
}
