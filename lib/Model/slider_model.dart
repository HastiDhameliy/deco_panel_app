// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  int? code;
  List<Sliderbanner>? sliderbanner;

  SliderModel({
    this.code,
    this.sliderbanner,
  });

  SliderModel copyWith({
    int? code,
    List<Sliderbanner>? sliderbanner,
  }) =>
      SliderModel(
        code: code ?? this.code,
        sliderbanner: sliderbanner ?? this.sliderbanner,
      );

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        code: json["code"],
        sliderbanner: json["sliderbanner"] == null
            ? []
            : List<Sliderbanner>.from(
                json["sliderbanner"]!.map((x) => Sliderbanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "sliderbanner": sliderbanner == null
            ? []
            : List<dynamic>.from(sliderbanner!.map((x) => x.toJson())),
      };
}

class Sliderbanner {
  String? sliderImage;

  Sliderbanner({
    this.sliderImage,
  });

  Sliderbanner copyWith({
    String? sliderImage,
  }) =>
      Sliderbanner(
        sliderImage: sliderImage ?? this.sliderImage,
      );

  factory Sliderbanner.fromJson(Map<String, dynamic> json) => Sliderbanner(
        sliderImage: json["slider_image"],
      );

  Map<String, dynamic> toJson() => {
        "slider_image": sliderImage,
      };
}
