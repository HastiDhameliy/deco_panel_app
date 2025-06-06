// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  int? code;
  List<CartItem>? data;

  CartModel({
    this.code,
    this.data,
  });

  CartModel copyWith({
    int? code,
    List<CartItem>? data,
  }) =>
      CartModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<CartItem>.from(
                json["data"]!.map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CartItem {
  int? id;
  int? productsCatgId;
  int? productsSubCatgId;
  String? productsBrand;
  String? productsThickness;
  String? productsUnit;
  int? productsSize1;
  int? productsSize2;
  String? productsSizeUnit;
  int? cartQuantity;
  String? productCategoryImage;
  RxBool? isSelected;

  CartItem({
    this.id,
    this.productsCatgId,
    this.productsSubCatgId,
    this.productsBrand,
    this.productsThickness,
    this.productsUnit,
    this.productsSize1,
    this.productsSize2,
    this.productsSizeUnit,
    this.cartQuantity,
    this.isSelected,
    this.productCategoryImage,
  });

  CartItem copyWith(
          {int? id,
          int? productsCatgId,
          int? productsSubCatgId,
          String? productsBrand,
          String? productsThickness,
          String? productsUnit,
          int? productsSize1,
          int? productsSize2,
          String? productsSizeUnit,
          int? cartQuantity,
          String? productCategoryImage,
          RxBool? isSelected}) =>
      CartItem(
        id: id ?? this.id,
        productsCatgId: productsCatgId ?? this.productsCatgId,
        productsSubCatgId: productsSubCatgId ?? this.productsSubCatgId,
        productsBrand: productsBrand ?? this.productsBrand,
        productsThickness: productsThickness ?? this.productsThickness,
        productsUnit: productsUnit ?? this.productsUnit,
        productsSize1: productsSize1 ?? this.productsSize1,
        productsSize2: productsSize2 ?? this.productsSize2,
        productsSizeUnit: productsSizeUnit ?? this.productsSizeUnit,
        cartQuantity: cartQuantity ?? this.cartQuantity,
        productCategoryImage: productCategoryImage ?? this.productCategoryImage,
        isSelected: isSelected ?? this.isSelected,
      );

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"],
        productsCatgId: json["products_catg_id"],
        productsSubCatgId: json["products_sub_catg_id"],
        productsBrand: json["products_brand"],
        productsThickness: json["products_thickness"],
        productsUnit: json["products_unit"],
        productsSize1: json["products_size1"],
        productsSize2: json["products_size2"],
        productsSizeUnit: json["products_size_unit"],
        cartQuantity: json["cart_quantity"],
        productCategoryImage: json["product_category_image"],
        isSelected: false.obs,
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
        "cart_quantity": cartQuantity,
        "product_category_image": productCategoryImage,
      };
}
