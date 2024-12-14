// To parse this JSON data, do
//
//     final orderItemDataModel = orderItemDataModelFromJson(jsonString);

import 'dart:convert';

OrderItemDataModel orderItemDataModelFromJson(String str) =>
    OrderItemDataModel.fromJson(json.decode(str));

String orderItemDataModelToJson(OrderItemDataModel data) =>
    json.encode(data.toJson());

class OrderItemDataModel {
  Order? order;
  List<OrderSub>? orderSub;

  OrderItemDataModel({
    this.order,
    this.orderSub,
  });

  OrderItemDataModel copyWith({
    Order? order,
    List<OrderSub>? orderSub,
  }) =>
      OrderItemDataModel(
        order: order ?? this.order,
        orderSub: orderSub ?? this.orderSub,
      );

  factory OrderItemDataModel.fromJson(Map<String, dynamic> json) =>
      OrderItemDataModel(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        orderSub: json["orderSub"] == null
            ? []
            : List<OrderSub>.from(
                json["orderSub"]!.map((x) => OrderSub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "orderSub": orderSub == null
            ? []
            : List<dynamic>.from(orderSub!.map((x) => x.toJson())),
      };
}

class Order {
  int? id;
  int? ordersUserId;
  int? ordersNo;
  String? ordersRef;
  DateTime? ordersDate;
  String? ordersStatus;
  dynamic ordersRemarks;

  Order({
    this.id,
    this.ordersUserId,
    this.ordersNo,
    this.ordersRef,
    this.ordersDate,
    this.ordersStatus,
    this.ordersRemarks,
  });

  Order copyWith({
    int? id,
    int? ordersUserId,
    int? ordersNo,
    String? ordersRef,
    DateTime? ordersDate,
    String? ordersStatus,
    dynamic ordersRemarks,
  }) =>
      Order(
        id: id ?? this.id,
        ordersUserId: ordersUserId ?? this.ordersUserId,
        ordersNo: ordersNo ?? this.ordersNo,
        ordersRef: ordersRef ?? this.ordersRef,
        ordersDate: ordersDate ?? this.ordersDate,
        ordersStatus: ordersStatus ?? this.ordersStatus,
        ordersRemarks: ordersRemarks ?? this.ordersRemarks,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        ordersUserId: json["orders_user_id"],
        ordersNo: json["orders_no"],
        ordersRef: json["orders_ref"],
        ordersDate: json["orders_date"] == null
            ? null
            : DateTime.parse(json["orders_date"]),
        ordersStatus: json["orders_status"],
        ordersRemarks: json["orders_remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders_user_id": ordersUserId,
        "orders_no": ordersNo,
        "orders_ref": ordersRef,
        "orders_date":
            "${ordersDate!.year.toString().padLeft(4, '0')}-${ordersDate!.month.toString().padLeft(2, '0')}-${ordersDate!.day.toString().padLeft(2, '0')}",
        "orders_status": ordersStatus,
        "orders_remarks": ordersRemarks,
      };
}

class OrderSub {
  dynamic id;
  String? ordersSubRef;
  dynamic ordersSubProduct;
  String? ordersSubBrand;
  String? ordersSubThickness;
  String? ordersSubUnit;
  dynamic ordersSubSize1;
  dynamic ordersSubSize2;
  String? ordersSubSizeUnit;
  dynamic ordersSubRate;
  dynamic ordersSubQuantity;
  dynamic ordersSubAmount;

  OrderSub({
    this.id,
    this.ordersSubRef,
    this.ordersSubProduct,
    this.ordersSubBrand,
    this.ordersSubThickness,
    this.ordersSubUnit,
    this.ordersSubSize1,
    this.ordersSubSize2,
    this.ordersSubSizeUnit,
    this.ordersSubRate,
    this.ordersSubQuantity,
    this.ordersSubAmount,
  });

  OrderSub copyWith({
    dynamic id,
    String? ordersSubRef,
    dynamic ordersSubProduct,
    String? ordersSubBrand,
    String? ordersSubThickness,
    String? ordersSubUnit,
    dynamic ordersSubSize1,
    dynamic ordersSubSize2,
    String? ordersSubSizeUnit,
    dynamic ordersSubRate,
    dynamic ordersSubQuantity,
    dynamic ordersSubAmount,
  }) =>
      OrderSub(
        id: id ?? this.id,
        ordersSubRef: ordersSubRef ?? this.ordersSubRef,
        ordersSubProduct: ordersSubProduct ?? this.ordersSubProduct,
        ordersSubBrand: ordersSubBrand ?? this.ordersSubBrand,
        ordersSubThickness: ordersSubThickness ?? this.ordersSubThickness,
        ordersSubUnit: ordersSubUnit ?? this.ordersSubUnit,
        ordersSubSize1: ordersSubSize1 ?? this.ordersSubSize1,
        ordersSubSize2: ordersSubSize2 ?? this.ordersSubSize2,
        ordersSubSizeUnit: ordersSubSizeUnit ?? this.ordersSubSizeUnit,
        ordersSubRate: ordersSubRate ?? this.ordersSubRate,
        ordersSubQuantity: ordersSubQuantity ?? this.ordersSubQuantity,
        ordersSubAmount: ordersSubAmount ?? this.ordersSubAmount,
      );

  factory OrderSub.fromJson(Map<String, dynamic> json) => OrderSub(
        id: json["id"],
        ordersSubRef: json["orders_sub_ref"],
        ordersSubProduct: json["orders_sub_product"],
        ordersSubBrand: json["orders_sub_brand"],
        ordersSubThickness: json["orders_sub_thickness"],
        ordersSubUnit: json["orders_sub_unit"],
        ordersSubSize1: json["orders_sub_size1"],
        ordersSubSize2: json["orders_sub_size2"],
        ordersSubSizeUnit: json["orders_sub_size_unit"],
        ordersSubRate: json["orders_sub_rate"],
        ordersSubQuantity: json["orders_sub_quantity"],
        ordersSubAmount: json["orders_sub_amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orders_sub_ref": ordersSubRef,
        "orders_sub_product": ordersSubProduct,
        "orders_sub_brand": ordersSubBrand,
        "orders_sub_thickness": ordersSubThickness,
        "orders_sub_unit": ordersSubUnit,
        "orders_sub_size1": ordersSubSize1,
        "orders_sub_size2": ordersSubSize2,
        "orders_sub_size_unit": ordersSubSizeUnit,
        "orders_sub_rate": ordersSubRate,
        "orders_sub_quantity": ordersSubQuantity,
        "orders_sub_amount": ordersSubAmount,
      };
}
