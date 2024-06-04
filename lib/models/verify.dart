// To parse this JSON data, do
//
//     final verify = verifyFromJson(jsonString);

import 'dart:convert';

Verify verifyFromJson(String str) => Verify.fromJson(json.decode(str));

String verifyToJson(Verify data) => json.encode(data.toJson());

class Verify {
  final bool? success;
  final String? message;
  final Data? data;

  Verify({
    this.success,
    this.message,
    this.data,
  });

  factory Verify.fromJson(Map<String, dynamic> json) => Verify(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? access;
  final String? refresh;

  Data({
    this.access,
    this.refresh,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    access: json["access"],
    refresh: json["refresh"],
  );

  Map<String, dynamic> toJson() => {
    "access": access,
    "refresh": refresh,
  };
}
