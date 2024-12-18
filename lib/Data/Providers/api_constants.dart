class ApiConstants {
  // static String baseUrl = 'http://127.0.0.1:8000/api_seller/';
  // static String baseUrl = 'https://euphora.vrutiitsolution.com/api/';
  // static String baseImageUrl = 'https://euphora.vrutiitsolution.com/image/';
  //  static String baseUrl = 'https://euphora.vruttiitsolutions.com/api/';
  // static String baseImageUrl = 'https://euphora.vruttiitsolutions.com/image/';
  static String baseUrl = 'https://decopanel.in/public/api/';
  static String imageBaseUrl = 'https://decopanel.in/storage/app/public/';

  static String checkMobileApiUrl = '${baseUrl}check-mobile?mobile=';
  static String loginApiUrl = '${baseUrl}login?mobile=';
  static String createUserUrl = '${baseUrl}create-user';

  /// ////////////// FETCH ALL CATEGORY AND SLIDER ///////////////////
  static String fetchSliderApiUrl = '${baseUrl}fetch-slider';

  static String fetchProductCategoryApiUrl =
      '${baseUrl}fetch-products-category';

  static String fetchSubCategoryApiUrl =
      '${baseUrl}fetch-products-sub-category';

  /// ////////////// FETCH ALL FILTERS ///////////////////
  static String fetchBrandsApiUrl = '${baseUrl}fetch-brands';
  static String fetchThicknessApiUrl = '${baseUrl}fetch-thickness';
  static String fetchSizeApiUrl = '${baseUrl}fetch-size';
  static String fetchProductApiUrl = '${baseUrl}fetch-products';

  /// /////////////   //// Cart ////   ///////////////////

  static String createCartApiUrl = '${baseUrl}create-cart';
  static String fetchCartApiUrl = '${baseUrl}fetch-cart';
  static String updateCartApiUrl = '${baseUrl}update-cart';
  static String deleteCartApiUrl = '${baseUrl}delete-cart-single-item';

  /// /////////////   //// Offer ////   ///////////////////

  static String fetchOfferApiUrl = '${baseUrl}fetch-offer';

  /// /////////////   //// Profile ////   ///////////////////
  static String updateProfileApiUrl = '${baseUrl}update-user-by-id';

  /// ////////////// FETCH PROFILE ///////////////////
  static String fetchProfileApiUrl = '${baseUrl}fetch-user';

  /// ////////////// FETCH FEEDBACK ///////////////////
  static String addFeedbackApiUrl = '${baseUrl}create-feedback';

  /// ////////////// FETCH ORDER ///////////////////
  static String getOrderApiUrl = '${baseUrl}fetch-order';
  static String createOrderApiUrl = '${baseUrl}create-order';
  static String createOrderByIdApiUrl = '${baseUrl}fetch-order-by-id';
  static String getAdminOrderApiUrl = '${baseUrl}fetch-admin-order';
  static String getQuotationApiUrl = '${baseUrl}fetch-quotation';
  static String updateQuotationApiUrl = '${baseUrl}update-quotation';
}
