import 'package:get/get.dart';

import '../Controller/bottom_nav_controller.dart';
import '../Controller/category_controller.dart';
import '../Controller/feedback_controller.dart';
import '../Controller/login_controller.dart';
import '../Controller/otp_controller.dart';
import '../Controller/past_order_controller.dart';
import '../Controller/profile_controller.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => OtpController());
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => PastOrderController());
    Get.lazyPut(() => FeedbackController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => ProfileController());
  }
}
