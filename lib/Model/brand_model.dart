// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  int? code;
  List<BrandData>? data;

  BrandModel({
    this.code,
    this.data,
  });

  BrandModel copyWith({
    int? code,
    List<BrandData>? data,
  }) =>
      BrandModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<BrandData>.from(
                json["data"]!.map((x) => BrandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BrandData {
  String? productsBrand;

  BrandData({
    this.productsBrand,
  });

  BrandData copyWith({
    String? productsBrand,
  }) =>
      BrandData(
        productsBrand: productsBrand ?? this.productsBrand,
      );

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
        productsBrand: json["products_brand"],
      );

  Map<String, dynamic> toJson() => {
        "products_brand": productsBrand,
      };
}

// To parse this JSON data, do
//
//     final thicknessModel = thicknessModelFromJson(jsonString);

ThicknessModel thicknessModelFromJson(String str) =>
    ThicknessModel.fromJson(json.decode(str));

String thicknessModelToJson(ThicknessModel data) => json.encode(data.toJson());

class ThicknessModel {
  int? code;
  List<ThicknessData>? data;

  ThicknessModel({
    this.code,
    this.data,
  });

  ThicknessModel copyWith({
    int? code,
    List<ThicknessData>? data,
  }) =>
      ThicknessModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory ThicknessModel.fromJson(Map<String, dynamic> json) => ThicknessModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<ThicknessData>.from(
                json["data"]!.map((x) => ThicknessData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ThicknessData {
  String? productsThickness;
  String? productsUnit;

  ThicknessData({
    this.productsThickness,
    this.productsUnit,
  });

  ThicknessData copyWith({
    String? productsThickness,
    String? productsUnit,
  }) =>
      ThicknessData(
        productsThickness: productsThickness ?? this.productsThickness,
        productsUnit: productsUnit ?? this.productsUnit,
      );

  factory ThicknessData.fromJson(Map<String, dynamic> json) => ThicknessData(
        productsThickness: json["products_thickness"],
        productsUnit: json["products_unit"],
      );

  Map<String, dynamic> toJson() => {
        "products_thickness": productsThickness,
        "products_unit": productsUnit,
      };
}
// To parse this JSON data, do
//
//     final sizeModel = sizeModelFromJson(jsonString);

SizeModel sizeModelFromJson(String str) => SizeModel.fromJson(json.decode(str));

String sizeModelToJson(SizeModel data) => json.encode(data.toJson());

class SizeModel {
  int? code;
  List<SizeData>? data;

  SizeModel({
    this.code,
    this.data,
  });

  SizeModel copyWith({
    int? code,
    List<SizeData>? data,
  }) =>
      SizeModel(
        code: code ?? this.code,
        data: data ?? this.data,
      );

  factory SizeModel.fromJson(Map<String, dynamic> json) => SizeModel(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<SizeData>.from(
                json["data"]!.map((x) => SizeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SizeData {
  int? productsSize1;
  int? productsSize2;
  String? productsSizeUnit;

  SizeData({
    this.productsSize1,
    this.productsSize2,
    this.productsSizeUnit,
  });

  SizeData copyWith({
    int? productsSize1,
    int? productsSize2,
    String? productsSizeUnit,
  }) =>
      SizeData(
        productsSize1: productsSize1 ?? this.productsSize1,
        productsSize2: productsSize2 ?? this.productsSize2,
        productsSizeUnit: productsSizeUnit ?? this.productsSizeUnit,
      );

  factory SizeData.fromJson(Map<String, dynamic> json) => SizeData(
        productsSize1: json["products_size1"],
        productsSize2: json["products_size2"],
        productsSizeUnit: json["products_size_unit"],
      );

  Map<String, dynamic> toJson() => {
        "products_size1": productsSize1,
        "products_size2": productsSize2,
        "products_size_unit": productsSizeUnit,
      };
}
