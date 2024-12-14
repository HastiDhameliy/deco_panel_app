import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:get/get.dart';

import '../Model/user_detail_model.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  Rx<UserDataModel> useDataModel = UserDataModel().obs;

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    getProfileData();
    super.onReady();
  }

  void getProfileData() async {
    useDataModel.value = await ApiService().fetchUserApiUrl(
      loading: isLoading,
    );
  }
}
