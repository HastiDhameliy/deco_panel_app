import 'package:deco_flutter_app/Controller/past_order_controller.dart';
import 'package:deco_flutter_app/Controller/profile_controller.dart';
import 'package:deco_flutter_app/Data/Services/api_service.dart';
import 'package:deco_flutter_app/Model/product_model.dart';
import 'package:deco_flutter_app/Util/custom/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/Services/product_api_service.dart';
import '../Model/brand_model.dart';
import '../Model/offer_model.dart';
import '../Model/product_category_model.dart';
import '../Model/slider_model.dart';
import '../Model/sub_category_item_model.dart';

class BottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedIndex = 0.obs; // Observable for the selected index
  RxBool isLoading = false.obs;
  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingOffer = false.obs;
  RxBool isLoadingSubCategory = false.obs;
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  RxBool isLoadingTrue = false.obs;
  RxBool isLoadingBrand = false.obs;
  RxBool isLoadingThick = false.obs;
  RxBool isLoadingSize = false.obs;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingCCart = false.obs;

  Rx<CategoryData> categoryData = CategoryData().obs;
  Rx<SliderModel> sliderModel = SliderModel().obs;
  Rx<ProductCategoryModel> productCategoryModel = ProductCategoryModel().obs;
  Rx<SubCategoryModel> subCategoryModel = SubCategoryModel().obs;
  RxList<SubCategoryData> subCategoryData = <SubCategoryData>[].obs;
  RxList<Offerbanner> offerBannerList = <Offerbanner>[].obs;

  RxList<BrandData> brandList = <BrandData>[].obs;
  Rx<BrandData> selectedBrand = BrandData().obs;
  RxList<ThicknessData> thicknessList = <ThicknessData>[].obs;
  Rx<ThicknessData> selectedThick = ThicknessData().obs;
  Rx<SizeData> selectedSize = SizeData().obs;
  RxList<SizeData> sizeList = <SizeData>[].obs;
  RxList<CategoryProductItem> productItemList = <CategoryProductItem>[].obs;

  RxInt qty = 1.obs;
  RxInt currentSliderIndex = 1.obs;
  RxInt selectedProductIndex = (-1).obs;
  RxMap<int, bool> isLoadingMap = <int, bool>{}.obs;

  void setLoading(int index, bool isLoading) {
    isLoadingMap[index] = isLoading;
    update();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (userType == 1) {
      switch (index) {
        case 1:
          if (Get.find<PastOrderController>().tapIndex.value == 0) {
            Get.find<PastOrderController>().getOrder("1");
          } else {
            Get.find<PastOrderController>().getOrder("2");
          }
        case 2:
          Get.find<PastOrderController>().getOrderList();
        case 3:
          Get.find<ProfileController>().getProfileData();
      }
    } else if (userType == 2) {
      switch (index) {
        case 0:
          if (Get.find<PastOrderController>().tapIndex.value == 0) {
            Get.find<PastOrderController>().getOrder("1");
          } else {
            Get.find<PastOrderController>().getOrder("2");
          }
        case 1:
          Get.find<ProfileController>().getProfileData();
      }
    }
  }

  var currentPage = 0.obs; // Observable to track the current page

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getData() async {
    sliderModel.value = await ApiService()
        .fetchSliderApi(context: Get.context!, loading: isLoading);
    productCategoryModel.value =
        await ApiService().fetchProductCategoryApi(loading: isLoadingCategory);
    offerBannerList.value =
        await ApiService().fetchOfferApi(loading: isLoadingOffer);
  }

  void getSubCategoryData(String id) async {
    subCategoryModel.value = await ApiService().fetchSubCategoryApiUrl(
        loading: isLoadingSubCategory, productCtgId: id);
  }

  void getProductData({
    required String id,
    required String subId,
    required BuildContext context,
  }) async {
    try {
      isLoadingTrue.value = true;
      // Start by fetching the brand list
      brandList.value = await ProductApiService().fetchBrandApiUrl(
        loading: isLoadingBrand,
        id: id,
        subId: subId,
      );

      // If brandList is empty, handle it (you can show an error or return early)
      if (brandList.isEmpty) {
        customToast(
            context, 'No brands found for add to cart', ToastType.warning);
        return;
      }

      // Proceed to fetch thickness data
      thicknessList.value = await ProductApiService().fetchThicknessApiUrl(
        loading: isLoadingBrand,
        id: id,
        subId: subId,
        brand: brandList.first.productsBrand ?? "",
      );

      // If thicknessList is empty, handle it (you can show an error or return early)
      if (thicknessList.isEmpty) {
        customToast(
            context, 'No thickness found for add to cart', ToastType.warning);
        return;
      }

      // Proceed to fetch size data
      sizeList.value = await ProductApiService().fetchSizeApiUrl(
        loading: isLoadingBrand,
        id: id,
        subId: subId,
        brand: brandList.first.productsBrand ?? "",
        thickness: thicknessList.first.productsThickness ?? '',
        unit: thicknessList.first.productsUnit ?? '',
      );

      // If sizeList is empty, handle it (you can show an error or return early)
      if (sizeList.isEmpty) {
        customToast(
            context, 'No size found for add to cart', ToastType.warning);
        return;
      }

      productItemList.value = await ProductApiService().fetchProductApiUrl(
        loading: isLoadingBrand,
        id: id,
        subId: subId,
        brand: brandList.first.productsBrand ?? "",
        thickness: thicknessList.first.productsThickness ?? '',
        unit: thicknessList.first.productsUnit ?? '',
        size1: sizeList.first.productsSize1?.toString() ?? '',
        size2: sizeList.first.productsSize2?.toString() ?? '',
        sizeUnit: sizeList.first.productsSizeUnit?.toString() ?? '',
      );

      // If sizeList is empty, handle it (you can show an error or return early)
      if (productItemList.isEmpty) {
        customToast(
            context, 'No Product found for add to cart', ToastType.warning);
        return;
      }
      isLoadingTrue.value = false;
    } catch (e) {
      isLoadingTrue.value = false;

      customToast(context, 'Error fetching data', ToastType.error);
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    if (userType == 1) getData();
    super.onReady();
  }
}
