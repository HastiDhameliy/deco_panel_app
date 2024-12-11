// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerModelFromJson(String str) =>
    OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  int? code;
  List<Offerbanner>? offerbanner;

  OfferModel({
    this.code,
    this.offerbanner,
  });

  OfferModel copyWith({
    int? code,
    List<Offerbanner>? offerbanner,
  }) =>
      OfferModel(
        code: code ?? this.code,
        offerbanner: offerbanner ?? this.offerbanner,
      );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        code: json["code"],
        offerbanner: json["offerbanner"] == null
            ? []
            : List<Offerbanner>.from(
                json["offerbanner"]!.map((x) => Offerbanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "offerbanner": offerbanner == null
            ? []
            : List<dynamic>.from(offerbanner!.map((x) => x.toJson())),
      };
}

class Offerbanner {
  String? offerHeading;
  String? offerLink;
  String? offerLinkText;
  String? offerImage;

  Offerbanner({
    this.offerHeading,
    this.offerLink,
    this.offerLinkText,
    this.offerImage,
  });

  Offerbanner copyWith({
    String? offerHeading,
    String? offerLink,
    String? offerLinkText,
    String? offerImage,
  }) =>
      Offerbanner(
        offerHeading: offerHeading ?? this.offerHeading,
        offerLink: offerLink ?? this.offerLink,
        offerLinkText: offerLinkText ?? this.offerLinkText,
        offerImage: offerImage ?? this.offerImage,
      );

  factory Offerbanner.fromJson(Map<String, dynamic> json) => Offerbanner(
        offerHeading: json["offer_heading"],
        offerLink: json["offer_link"],
        offerLinkText: json["offer_link_text"],
        offerImage: json["offer_image"],
      );

  Map<String, dynamic> toJson() => {
        "offer_heading": offerHeading,
        "offer_link": offerLink,
        "offer_link_text": offerLinkText,
        "offer_image": offerImage,
      };
}
