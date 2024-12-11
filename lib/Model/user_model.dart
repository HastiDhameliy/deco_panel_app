// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? code;
  String? msg;
  Data? data;

  UserModel({
    this.code,
    this.msg,
    this.data,
  });

  UserModel copyWith({
    int? code,
    String? msg,
    Data? data,
  }) =>
      UserModel(
        code: code ?? this.code,
        msg: msg ?? this.msg,
        data: data ?? this.data,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  String? token;
  User? user;

  Data({
    this.token,
    this.user,
  });

  Data copyWith({
    String? token,
    User? user,
  }) =>
      Data(
        token: token ?? this.token,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? fullName;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? state;
  String? pincode;
  int? userTypeId;
  DateTime? lastLogin;
  dynamic emailVerifiedAt;
  String? cpassword;
  String? token;
  String? userStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.fullName,
    this.name,
    this.email,
    this.mobile,
    this.address,
    this.state,
    this.pincode,
    this.userTypeId,
    this.lastLogin,
    this.emailVerifiedAt,
    this.cpassword,
    this.token,
    this.userStatus,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? fullName,
    String? name,
    String? email,
    String? mobile,
    String? address,
    String? state,
    String? pincode,
    int? userTypeId,
    DateTime? lastLogin,
    dynamic emailVerifiedAt,
    String? cpassword,
    String? token,
    String? userStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
        userTypeId: userTypeId ?? this.userTypeId,
        lastLogin: lastLogin ?? this.lastLogin,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        cpassword: cpassword ?? this.cpassword,
        token: token ?? this.token,
        userStatus: userStatus ?? this.userStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        address: json["address"],
        state: json["state"],
        pincode: json["pincode"],
        userTypeId: json["user_type_id"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        emailVerifiedAt: json["email_verified_at"],
        cpassword: json["cpassword"],
        token: json["token"],
        userStatus: json["user_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "name": name,
        "email": email,
        "mobile": mobile,
        "address": address,
        "state": state,
        "pincode": pincode,
        "user_type_id": userTypeId,
        "last_login":
            "${lastLogin!.year.toString().padLeft(4, '0')}-${lastLogin!.month.toString().padLeft(2, '0')}-${lastLogin!.day.toString().padLeft(2, '0')}",
        "email_verified_at": emailVerifiedAt,
        "cpassword": cpassword,
        "token": token,
        "user_status": userStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
