// To parse this JSON data, do
//
//     final quotationModel = quotationModelFromJson(jsonString);

import 'dart:convert';

QuotationModel quotationModelFromJson(String str) =>
    QuotationModel.fromJson(json.decode(str));

String quotationModelToJson(QuotationModel data) => json.encode(data.toJson());

class QuotationModel {
  int? code;
  Quotation? quotation;
  List<QuotationSub>? quotationSub;
  dynamic quotationSubSum;

  QuotationModel({
    this.code,
    this.quotation,
    this.quotationSub,
    this.quotationSubSum,
  });

  QuotationModel copyWith({
    int? code,
    Quotation? quotation,
    List<QuotationSub>? quotationSub,
    dynamic quotationSubSum,
  }) =>
      QuotationModel(
        code: code ?? this.code,
        quotation: quotation ?? this.quotation,
        quotationSub: quotationSub ?? this.quotationSub,
        quotationSubSum: quotationSubSum ?? this.quotationSubSum,
      );

  factory QuotationModel.fromJson(Map<String, dynamic> json) => QuotationModel(
        code: json["code"],
        quotation: json["quotation"] == null
            ? null
            : Quotation.fromJson(json["quotation"]),
        quotationSub: json["quotationSub"] == null
            ? []
            : List<QuotationSub>.from(
                json["quotationSub"]!.map((x) => QuotationSub.fromJson(x))),
        quotationSubSum: json["quotationSubSum"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "quotation": quotation?.toJson(),
        "quotationSub": quotationSub == null
            ? []
            : List<dynamic>.from(quotationSub!.map((x) => x.toJson())),
        "quotationSubSum": quotationSubSum,
      };
}

class Quotation {
  String? orderRef;
  int? quotationNo;
  DateTime? quotationDate;
  String? quotationRef;
  String? quotationStatus;
  dynamic quotationRemarks;
  String? fullName;

  Quotation({
    this.orderRef,
    this.quotationNo,
    this.quotationDate,
    this.quotationRef,
    this.quotationStatus,
    this.quotationRemarks,
    this.fullName,
  });

  Quotation copyWith({
    String? orderRef,
    int? quotationNo,
    DateTime? quotationDate,
    String? quotationRef,
    String? quotationStatus,
    dynamic quotationRemarks,
    String? fullName,
  }) =>
      Quotation(
        orderRef: orderRef ?? this.orderRef,
        quotationNo: quotationNo ?? this.quotationNo,
        quotationDate: quotationDate ?? this.quotationDate,
        quotationRef: quotationRef ?? this.quotationRef,
        quotationStatus: quotationStatus ?? this.quotationStatus,
        quotationRemarks: quotationRemarks ?? this.quotationRemarks,
        fullName: fullName ?? this.fullName,
      );

  factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
        orderRef: json["order_ref"],
        quotationNo: json["quotation_no"],
        quotationDate: json["quotation_date"] == null
            ? null
            : DateTime.parse(json["quotation_date"]),
        quotationRef: json["quotation_ref"],
        quotationStatus: json["quotation_status"],
        quotationRemarks: json["quotation_remarks"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "order_ref": orderRef,
        "quotation_no": quotationNo,
        "quotation_date":
            "${quotationDate!.year.toString().padLeft(4, '0')}-${quotationDate!.month.toString().padLeft(2, '0')}-${quotationDate!.day.toString().padLeft(2, '0')}",
        "quotation_ref": quotationRef,
        "quotation_status": quotationStatus,
        "quotation_remarks": quotationRemarks,
        "full_name": fullName,
      };
}

class QuotationSub {
  int? id;
  int? quotationSubProductId;
  String? productCategory;
  String? productSubCategory;
  String? quotationSubBrand;
  String? quotationSubThickness;
  String? quotationSubUnit;
  int? quotationSubSize1;
  int? quotationSubSize2;
  String? quotationSubSizeUnit;
  int? quotationSubQuantity;
  String? productCategoryImage;
  String? productSubCategoryImage;
  double? quotationSubRate;
  dynamic quotationSubAmount;

  QuotationSub({
    this.id,
    this.quotationSubProductId,
    this.productCategory,
    this.productSubCategory,
    this.quotationSubBrand,
    this.quotationSubThickness,
    this.quotationSubUnit,
    this.quotationSubSize1,
    this.quotationSubSize2,
    this.quotationSubSizeUnit,
    this.quotationSubQuantity,
    this.productCategoryImage,
    this.productSubCategoryImage,
    this.quotationSubRate,
    this.quotationSubAmount,
  });

  QuotationSub copyWith({
    int? id,
    int? quotationSubProductId,
    String? productCategory,
    String? productSubCategory,
    String? quotationSubBrand,
    String? quotationSubThickness,
    String? quotationSubUnit,
    int? quotationSubSize1,
    int? quotationSubSize2,
    String? quotationSubSizeUnit,
    int? quotationSubQuantity,
    String? productCategoryImage,
    String? productSubCategoryImage,
    double? quotationSubRate,
    dynamic quotationSubAmount,
  }) =>
      QuotationSub(
        id: id ?? this.id,
        quotationSubProductId:
            quotationSubProductId ?? this.quotationSubProductId,
        productCategory: productCategory ?? this.productCategory,
        productSubCategory: productSubCategory ?? this.productSubCategory,
        quotationSubBrand: quotationSubBrand ?? this.quotationSubBrand,
        quotationSubThickness:
            quotationSubThickness ?? this.quotationSubThickness,
        quotationSubUnit: quotationSubUnit ?? this.quotationSubUnit,
        quotationSubSize1: quotationSubSize1 ?? this.quotationSubSize1,
        quotationSubSize2: quotationSubSize2 ?? this.quotationSubSize2,
        quotationSubSizeUnit: quotationSubSizeUnit ?? this.quotationSubSizeUnit,
        quotationSubQuantity: quotationSubQuantity ?? this.quotationSubQuantity,
        productCategoryImage: productCategoryImage ?? this.productCategoryImage,
        productSubCategoryImage:
            productSubCategoryImage ?? this.productSubCategoryImage,
        quotationSubRate: quotationSubRate ?? this.quotationSubRate,
        quotationSubAmount: quotationSubAmount ?? this.quotationSubAmount,
      );

  factory QuotationSub.fromJson(Map<String, dynamic> json) => QuotationSub(
        id: json["id"],
        quotationSubProductId: json["quotation_sub_product_id"],
        productCategory: json["product_category"],
        productSubCategory: json["product_sub_category"],
        quotationSubBrand: json["quotation_sub_brand"],
        quotationSubThickness: json["quotation_sub_thickness"],
        quotationSubUnit: json["quotation_sub_unit"],
        quotationSubSize1: json["quotation_sub_size1"],
        quotationSubSize2: json["quotation_sub_size2"],
        quotationSubSizeUnit: json["quotation_sub_size_unit"],
        quotationSubQuantity: json["quotation_sub_quantity"],
        productCategoryImage: json["product_category_image"],
        productSubCategoryImage: json["product_sub_category_image"],
        quotationSubRate: json["quotation_sub_rate"]?.toDouble(),
        quotationSubAmount: json["quotation_sub_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quotation_sub_product_id": quotationSubProductId,
        "product_category": productCategory,
        "product_sub_category": productSubCategory,
        "quotation_sub_brand": quotationSubBrand,
        "quotation_sub_thickness": quotationSubThickness,
        "quotation_sub_unit": quotationSubUnit,
        "quotation_sub_size1": quotationSubSize1,
        "quotation_sub_size2": quotationSubSize2,
        "quotation_sub_size_unit": quotationSubSizeUnit,
        "quotation_sub_quantity": quotationSubQuantity,
        "product_category_image": productCategoryImage,
        "product_sub_category_image": productSubCategoryImage,
        "quotation_sub_rate": quotationSubRate,
        "quotation_sub_amount": quotationSubAmount,
      };
}
