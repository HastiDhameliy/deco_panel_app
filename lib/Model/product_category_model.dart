// To parse this JSON data, do
//
//     final productCategoryModel = productCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryModel productCategoryModelFromJson(String str) =>
    ProductCategoryModel.fromJson(json.decode(str));

String productCategoryModelToJson(ProductCategoryModel data) =>
    json.encode(data.toJson());

class ProductCategoryModel {
  int? code;
  List<CategoryData>? data;

  ProductCategoryModel({
    this.code,
    this.data,
  });

  ProductCategoryModel copyWith({
    int? code,
    List<CategoryData>? data,
  }) =>
      ProductCategoryModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) =>
      ProductCategoryModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<CategoryData>.from(
                json["data"]!.map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryData {
  int? id;
  String? productCategory;
  String? productCategoryImage;

  CategoryData({
    this.id,
    this.productCategory,
    this.productCategoryImage,
  });

  CategoryData copyWith({
    int? id,
    String? productCategory,
    String? productCategoryImage,
  }) =>
      CategoryData(
        id: id ?? this.id,
        productCategory: productCategory ?? this.productCategory,
        productCategoryImage: productCategoryImage ?? this.productCategoryImage,
      );

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        productCategory: json["product_category"],
        productCategoryImage: json["product_category_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category": productCategory,
        "product_category_image": productCategoryImage,
      };
}
