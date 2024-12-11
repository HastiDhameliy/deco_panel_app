import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/bottom_nav_controller.dart';
import '../../../Controller/profile_controller.dart';
import '../../../RoutesManagment/routes.dart';
import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_images.dart';
import '../../../Util/Constant/app_size.dart';
import '../../bottom_navigation/bottom_navigation_bar_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List drawerItem = [
    {1: "Home", 2: AppImages.homeIcon},
    {1: "Profile", 2: AppImages.profileIcon},
    {1: "Order List ", 2: AppImages.orderListIcon},
    {1: "Reward Points", 2: AppImages.pastOrdersIcon},
    {1: "Feedback", 2: AppImages.feedbackIcon},
    {1: "About Us", 2: AppImages.aboutUsIconIcon},
    {1: "Logout", 2: AppImages.logoutIcon},
  ];

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
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
                profileController.useDataModel.value.data?.fullName ?? "",
                style: GoogleFonts.ptSans(
                  color: AppColors.darkHintColor,
                  fontSize: Get.height / 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                profileController.useDataModel.value.data?.email ?? "",
                style: GoogleFonts.roboto(
                  color: AppColors.darkHintColor,
                  fontSize: Get.height / 65,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
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
              onTap: () {
                var con = Get.find<BottomNavController>();
                switch (index) {
                  case 0:
                    scaffoldKey.currentState?.closeDrawer();
                    con.changeIndex(0);
                    break;
                  case 1:
                    scaffoldKey.currentState?.closeDrawer();
                    con.changeIndex(3);
                    break;
                  case 2:
                    scaffoldKey.currentState?.closeDrawer();
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
                    Get.offAndToNamed(RouteConstants.loginScreen);
                    break;
                  default:
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
