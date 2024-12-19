import 'dart:developer';

import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/View/home/component/drawer_widget.dart';
import 'package:deco_flutter_app/View/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Controller/bottom_nav_controller.dart';
import '../../Controller/past_order_controller.dart';
import '../order_list/order_list_screen.dart';
import '../past_order/past_order_screen.dart';
import '../profile/profile_screen.dart';
import '../quotation/current_quotation_screen.dart';

class AnimatedBottomNavBar extends GetView<BottomNavController> {
  final List<dynamic> icons = [
    if (userType == 1) AppImages.homeIcon,
    AppImages.orderListIcon,
    if (userType == 1) AppImages.cartIcon,
    if (userType != 1) AppImages.quotationIcon,
    AppImages.profileIcon,
  ];

  final List<dynamic> selectedIcons = [
    if (userType == 1) AppImages.homeSeIcon,
    AppImages.orderListFillIcon,
    if (userType == 1) AppImages.cartIcon,
    if (userType != 1) AppImages.quotationIcon,
    AppImages.profileFillIcon,
  ];

  final List<String> titles = [
    if (userType == 1) 'Home',
    'Order List',
    if (userType == 1) 'Cart',
    if (userType != 1) 'Current Quotation',
    'Profile',
  ];

  final List<Widget> screens = [
    if (userType == 1) const HomeScreen(),
    const PastOrderScreen(),
    if (userType == 1) const OrderListScreen(),
    if (userType != 1) const CurrentQuotationScreen(),
    const ProfileScreen(),
  ];

  AnimatedBottomNavBar({super.key});

  // Define the GlobalKey for the Scaffold

  @override
  Widget build(BuildContext context) {
    log(token);
    print(userDetails.data?.user?.userTypeId);
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (!controller.canCloseApp()) {
            Get.snackbar('Hold On', 'Press back again to exit',
                snackPosition: SnackPosition.BOTTOM);
            return false;
          }
          return true;
        },
        child: Scaffold(
          key: controller.drawerKey,
          // Assign the scaffold key to the Scaffold widget
          drawerEnableOpenDragGesture: true,
          // Set to true to allow swipe gestures
          drawer: const DrawerWidget(),
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
                  color: controller.selectedIndex.value != 1
                      ? Colors.black.withOpacity(0.1)
                      : Colors.transparent,
                  // Light shadow color
                  blurRadius: 10.0,
                  // Soften the shadow
                  offset: const Offset(0, 4), // Shadow appears below the AppBar
                ),
              ],
            )),
            leading: IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () {
                controller.drawerKey.currentState
                    ?.openDrawer(); // Use openDrawer to open the left drawer
              },
            ),
            actions: [
              if (controller.selectedIndex.value != 2 && userType == 1)
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.changeIndex(2);
                        // Your onPressed action
                      },
                      icon: Image.asset(
                        AppImages.cartIcon,
                        height: AppSize.displayHeight(context) * 0.025,
                      ),
                    ),
                    Obx(
                      () => Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.buttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${Get.find<PastOrderController>().cartList.length}', // Observed count
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(right: AppSize.displayWidth(context) * 0.02),
            ],
            title: Text(
              controller.selectedIndex.value == 0
                  ? "Deco Panel"
                  : titles[controller.selectedIndex.value],
              style: GoogleFonts.roboto(
                color: AppColors.color333,
                fontSize: Get.height / 35,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Obx(() => screens[controller.selectedIndex.value]),
          bottomNavigationBar: Obx(
            () => Container(
              padding: EdgeInsets.symmetric(
                  vertical: AppSize.displayHeight(context) * 0.005),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    // Light shadow color
                    blurRadius: 10.0,
                    // Soften the shadow
                    offset:
                        const Offset(0, -4), // Shadow appears above the button
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: controller.selectedIndex.value,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.buttonColor,
                unselectedItemColor: Colors.grey,
                elevation: 0,
                onTap: controller.changeIndex,
                items: List.generate(userType == 1 ? 4 : 3, (index) {
                  return BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        AnimatedIconOrImageWidget(
                          iconData: controller.selectedIndex.value == index
                              ? selectedIcons[index]
                              : icons[index],
                          isSelected: controller.selectedIndex.value == index,
                        ),
                        index == 2 && userType == 1
                            ? Obx(
                                () => Positioned(
                                  right: -7,
                                  top: -9,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: controller.selectedIndex.value !=
                                              index
                                          ? AppColors.color333.withOpacity(0.6)
                                          : AppColors.buttonColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${Get.find<PastOrderController>().cartList.length}', // Observed count
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    label: titles[index],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedIconOrImageWidget extends StatefulWidget {
  final dynamic iconData; // Can be either IconData or Image path (String)
  final bool isSelected;

  const AnimatedIconOrImageWidget({
    super.key,
    required this.iconData,
    required this.isSelected,
  });

  @override
  AnimatedIconOrImageWidgetState createState() =>
      AnimatedIconOrImageWidgetState();
}

class AnimatedIconOrImageWidgetState extends State<AnimatedIconOrImageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedIconOrImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.isSelected ? 1.2 : 1.0, // Animate scale for selection
      duration: const Duration(milliseconds: 300),
      child: widget.iconData is IconData
          ? Icon(
              widget.iconData,
              size: AppSize.displayHeight(context) * 0.03, // Set the icon size
              color: widget.isSelected
                  ? AppColors.buttonColor
                  : Colors.grey, // Color change
            )
          : Image.asset(
              widget.iconData, // Assuming iconData is a string (asset path)
              width:
                  AppSize.displayWidth(context) * 0.055, // Set the image size
              height:
                  AppSize.displayWidth(context) * 0.055, // Set the image size
              color: widget.isSelected
                  ? AppColors.buttonColor
                  : Colors.grey, // Color change
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
