// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  int? code;
  List<OrderItemData>? data;

  OrderModel({
    this.code,
    this.data,
  });

  OrderModel copyWith({
    int? code,
    List<OrderItemData>? data,
  }) =>
      OrderModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<OrderItemData>.from(
                json["data"]!.map((x) => OrderItemData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderItemData {
  int? id;
  int? ordersNo;
  String? ordersRef;
  DateTime? ordersDate;
  String? productCategory;
  String? productSubCategory;
  String? productCategoryImage;
  String? productSubCategoryImage;
  String? ordersSubBrand;
  dynamic ordersSubProduct;
  int? ordersSubQuantity;
  String? ordersStatus;
  String? fullName;

  OrderItemData({
    this.id,
    this.ordersNo,
    this.ordersRef,
    this.ordersDate,
    this.productCategory,
    this.productSubCategory,
    this.productCategoryImage,
    this.productSubCategoryImage,
    this.ordersSubBrand,
    this.ordersSubProduct,
    this.ordersSubQuantity,
    this.ordersStatus,
    this.fullName,
  });

  OrderItemData copyWith({
    int? id,
    int? ordersNo,
    String? ordersRef,
    DateTime? ordersDate,
    String? productCategory,
    String? productSubCategory,
    String? productCategoryImage,
    String? productSubCategoryImage,
    String? ordersSubBrand,
    dynamic ordersSubProduct,
    int? ordersSubQuantity,
    String? ordersStatus,
    String? fullName,
  }) =>
      OrderItemData(
        id: id ?? this.id,
        ordersNo: ordersNo ?? this.ordersNo,
        ordersRef: ordersRef ?? this.ordersRef,
        ordersDate: ordersDate ?? this.ordersDate,
        productCategory: productCategory ?? this.productCategory,
        productSubCategory: productSubCategory ?? this.productSubCategory,
        productCategoryImage: productCategoryImage ?? this.productCategoryImage,
        productSubCategoryImage:
            productSubCategoryImage ?? this.productSubCategoryImage,
        ordersSubBrand: ordersSubBrand ?? this.ordersSubBrand,
        ordersSubProduct: ordersSubProduct ?? this.ordersSubProduct,
        ordersSubQuantity: ordersSubQuantity ?? this.ordersSubQuantity,
        ordersStatus: ordersStatus ?? this.ordersStatus,
        fullName: fullName ?? this.fullName,
      );

  factory OrderItemData.fromJson(Map<String, dynamic> json) => OrderItemData(
        id: json["id"],
        ordersNo: json["orders_no"],
        ordersRef: json["orders_ref"],
        ordersDate: json["orders_date"] == null
            ? null
            : DateTime.parse(json["orders_date"]),
        productCategory: json["product_category"],
        productSubCategory: json["product_sub_category"],
        productCategoryImage: json["product_category_image"],
        productSubCategoryImage: json["product_sub_category_image"],
        ordersSubBrand: json["orders_sub_brand"],
        ordersSubProduct: json["orders_sub_product"],
        ordersSubQuantity: json["orders_sub_quantity"],
        ordersStatus: json["orders_status"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders_no": ordersNo,
        "orders_ref": ordersRef,
        "orders_date":
            "${ordersDate!.year.toString().padLeft(4, '0')}-${ordersDate!.month.toString().padLeft(2, '0')}-${ordersDate!.day.toString().padLeft(2, '0')}",
        "product_category": productCategory,
        "product_sub_category": productSubCategory,
        "product_category_image": productCategoryImage,
        "product_sub_category_image": productSubCategoryImage,
        "orders_sub_brand": ordersSubBrand,
        "orders_sub_product": ordersSubProduct,
        "orders_sub_quantity": ordersSubQuantity,
        "orders_status": ordersStatus,
        "full_name": fullName,
      };
}
