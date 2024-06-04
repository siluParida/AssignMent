// To parse this JSON data, do
//
//     final delete = deleteFromJson(jsonString);

import 'dart:convert';

Delete deleteFromJson(String str) => Delete.fromJson(json.decode(str));

String deleteToJson(Delete data) => json.encode(data.toJson());

class Delete {
  final String? message;
  final bool? success;

  Delete({
    this.message,
    this.success,
  });

  factory Delete.fromJson(Map<String, dynamic> json) => Delete(
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
  };
}
