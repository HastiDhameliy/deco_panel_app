// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int? code;
  List<CategoryProductItem>? data;

  ProductModel({
    this.code,
    this.data,
  });

  ProductModel copyWith({
    int? code,
    List<CategoryProductItem>? data,
  }) =>
      ProductModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<CategoryProductItem>.from(
                json["data"]!.map((x) => CategoryProductItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryProductItem {
  int? id;
  int? productsCatgId;
  int? productsSubCatgId;
  String? productsBrand;
  String? productsThickness;
  String? productsUnit;
  int? productsSize1;
  int? productsSize2;
  String? productsSizeUnit;
  String? productCategoryImage;

  CategoryProductItem({
    this.id,
    this.productsCatgId,
    this.productsSubCatgId,
    this.productsBrand,
    this.productsThickness,
    this.productsUnit,
    this.productsSize1,
    this.productsSize2,
    this.productsSizeUnit,
    this.productCategoryImage,
  });

  CategoryProductItem copyWith({
    int? id,
    int? productsCatgId,
    int? productsSubCatgId,
    String? productsBrand,
    String? productsThickness,
    String? productsUnit,
    int? productsSize1,
    int? productsSize2,
    String? productsSizeUnit,
    String? productCategoryImage,
  }) =>
      CategoryProductItem(
        id: id ?? this.id,
        productsCatgId: productsCatgId ?? this.productsCatgId,
        productsSubCatgId: productsSubCatgId ?? this.productsSubCatgId,
        productsBrand: productsBrand ?? this.productsBrand,
        productsThickness: productsThickness ?? this.productsThickness,
        productsUnit: productsUnit ?? this.productsUnit,
        productsSize1: productsSize1 ?? this.productsSize1,
        productsSize2: productsSize2 ?? this.productsSize2,
        productsSizeUnit: productsSizeUnit ?? this.productsSizeUnit,
        productCategoryImage: productCategoryImage ?? this.productCategoryImage,
      );

  factory CategoryProductItem.fromJson(Map<String, dynamic> json) =>
      CategoryProductItem(
        id: json["id"],
        productsCatgId: json["products_catg_id"],
        productsSubCatgId: json["products_sub_catg_id"],
        productsBrand: json["products_brand"],
        productsThickness: json["products_thickness"],
        productsUnit: json["products_unit"],
        productsSize1: json["products_size1"],
        productsSize2: json["products_size2"],
        productsSizeUnit: json["products_size_unit"],
        productCategoryImage: json["product_category_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products_catg_id": productsCatgId,
        "products_sub_catg_id": productsSubCatgId,
        "products_brand": productsBrand,
        "products_thickness": productsThickness,
        "products_unit": productsUnit,
        "products_size1": productsSize1,
        "products_size2": productsSize2,
        "products_size_unit": productsSizeUnit,
        "product_category_image": productCategoryImage,
      };
}
