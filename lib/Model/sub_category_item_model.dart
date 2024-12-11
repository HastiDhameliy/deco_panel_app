// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  int? code;
  List<SubCategoryData>? data;

  SubCategoryModel({
    this.code,
    this.data,
  });

  SubCategoryModel copyWith({
    int? code,
    List<SubCategoryData>? data,
  }) =>
      SubCategoryModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<SubCategoryData>.from(
                json["data"]!.map((x) => SubCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SubCategoryData {
  int? id;
  String? productSubCategory;
  dynamic productSubCategoryImage;

  SubCategoryData({
    this.id,
    this.productSubCategory,
    this.productSubCategoryImage,
  });

  SubCategoryData copyWith({
    int? id,
    String? productSubCategory,
    dynamic productSubCategoryImage,
  }) =>
      SubCategoryData(
        id: id ?? this.id,
        productSubCategory: productSubCategory ?? this.productSubCategory,
        productSubCategoryImage:
            productSubCategoryImage ?? this.productSubCategoryImage,
      );

  factory SubCategoryData.fromJson(Map<String, dynamic> json) =>
      SubCategoryData(
        id: json["id"],
        productSubCategory: json["product_sub_category"],
        productSubCategoryImage: json["product_sub_category_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_sub_category": productSubCategory,
        "product_sub_category_image": productSubCategoryImage,
      };
}
