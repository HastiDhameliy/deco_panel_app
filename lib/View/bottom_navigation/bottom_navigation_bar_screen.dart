import 'dart:developer';

import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Util/Constant/app_colors.dart';
import 'package:deco_flutter_app/Util/Constant/app_images.dart';
import 'package:deco_flutter_app/Util/Constant/app_size.dart';
import 'package:deco_flutter_app/View/home/component/drawer_widget.dart';
import 'package:deco_flutter_app/View/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/bottom_nav_controller.dart';
import '../order_list/order_list_screen.dart';
import '../past_order/past_order_screen.dart';
import '../profile/profile_screen.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class AnimatedBottomNavBar extends GetView<BottomNavController> {
  final List<dynamic> icons = [
    AppImages.homeIcon,
    AppImages.pastOrdersIcon,
    AppImages.orderListIcon,
    AppImages.profileIcon,
  ];

  final List<dynamic> selectedIcons = [
    AppImages.homeSeIcon,
    AppImages.pastOrdersFillIcon,
    AppImages.orderListFillIcon,
    AppImages.profileFillIcon,
  ];

  final List<String> titles = [
    'Home',
    'Past Order',
    'Order List',
    'Profile',
  ];

  final List<Widget> screens = [
    const HomeScreen(),
    const PastOrderScreen(),
    const OrderListScreen(),
    const ProfileScreen(),
  ];

  AnimatedBottomNavBar({super.key});

  // Define the GlobalKey for the Scaffold

  @override
  Widget build(BuildContext context) {
    log(token);
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
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
              scaffoldKey.currentState
                  ?.openDrawer(); // Use openDrawer to open the left drawer
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppImages.cartIcon,
                height: AppSize.displayHeight(context) * 0.025,
              ),
            )
          ],
          title: Text(controller.selectedIndex.value == 0
              ? "Deco Panel"
              : titles[controller.selectedIndex.value]),
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
              items: List.generate(4, (index) {
                return BottomNavigationBarItem(
                  icon: AnimatedIconOrImageWidget(
                    iconData: controller.selectedIndex.value == index
                        ? selectedIcons[index]
                        : icons[index],
                    isSelected: controller.selectedIndex.value == index,
                  ),
                  label: titles[index],
                );
              }),
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
