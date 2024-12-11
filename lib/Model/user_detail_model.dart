// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  int? code;
  String? msg;
  Data? data;

  UserDataModel({
    this.code,
    this.msg,
    this.data,
  });

  UserDataModel copyWith({
    int? code,
    String? msg,
    Data? data,
  }) =>
      UserDataModel(
        code: code ?? this.code,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? mobile;
  String? address;
  String? state;
  String? pincode;
  String? cpassword;
  String? userStatus;
  DateTime? lastLogin;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.mobile,
    this.address,
    this.state,
    this.pincode,
    this.cpassword,
    this.userStatus,
    this.lastLogin,
  });

  Data copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobile,
    String? address,
    String? state,
    String? pincode,
    String? cpassword,
    String? userStatus,
    DateTime? lastLogin,
  }) =>
      Data(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        cpassword: cpassword ?? this.cpassword,
        userStatus: userStatus ?? this.userStatus,
        lastLogin: lastLogin ?? this.lastLogin,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        state: json["state"],
        pincode: json["pincode"],
        cpassword: json["cpassword"],
        userStatus: json["user_status"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "mobile": mobile,
        "address": address,
        "state": state,
        "pincode": pincode,
        "cpassword": cpassword,
        "user_status": userStatus,
        "last_login":
            "${lastLogin!.year.toString().padLeft(4, '0')}-${lastLogin!.month.toString().padLeft(2, '0')}-${lastLogin!.day.toString().padLeft(2, '0')}",
      };
}
