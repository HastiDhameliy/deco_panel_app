import 'package:deco_flutter_app/RoutesManagment/routes.dart';
import 'package:deco_flutter_app/RoutesManagment/screen_bindings.dart';
import 'package:get/get.dart';

import '../View/auth/login_screen.dart';
import '../View/auth/verification_code.dart';
import '../View/bottom_navigation/bottom_navigation_bar_screen.dart';
import '../View/home/component/category_item_screen.dart';
import '../View/home/home_screen.dart';
import '../View/past_order/past_order_screen.dart';
import '../View/services/about_us_screen.dart';
import '../View/services/feedback_screen.dart';
import '../View/services/reward_point.dart';
import '../View/splash_screen.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: RouteConstants.splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.loginScreen,
          page: () => LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.otpScreen,
          page: () => const OtpScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.animatedBottomNavBar,
          page: () => AnimatedBottomNavBar(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.homeScreen,
          page: () => const HomeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.pastOrderScreen,
          page: () => const PastOrderScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.feedBackScreen,
          page: () => FeedBackScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.aboutUsScreen,
          page: () => const AboutUsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.rewardPoint,
          page: () => const RewardPoint(),
          binding: ScreenBindings()),
      GetPage(
          name: RouteConstants.categoryItemScreen,
          page: () => const CategoryItemScreen(),
          binding: ScreenBindings()),
    ];
  }
}
