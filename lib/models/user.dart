import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final bool? success;
  final String? message;
  final Data? data;

  User({
    this.success,
    this.message,
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  final UserClass? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };
}

class UserClass {
  final int? id;
  final String? name;
  final dynamic email;
  final String? phoneNumber;
  final String? gender;
  final String? placeOfBirth;
  final DateTime? dateOfBirth;
  final DateTime? timeOfBirth;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic socketId;

  UserClass({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.placeOfBirth,
    this.dateOfBirth,
    this.timeOfBirth,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.socketId,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"],
    name: json["name"] ?? "",
    email: json["email"],
    phoneNumber: json["phoneNumber"] ?? "",
    gender: json["gender"] ?? "",
    placeOfBirth: json["place_of_birth"] ?? "",
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]?? "") ,
    timeOfBirth: json["time_of_birth"] == null ? null : DateTime.parse(json["time_of_birth"]?? ""),
    status: json["status"] ?? "",
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    socketId: json["socketId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "gender": gender,
    "place_of_birth": placeOfBirth,
    "date_of_birth": dateOfBirth?.toIso8601String() ,
    "time_of_birth": timeOfBirth?.toIso8601String(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "socketId": socketId,
  };
}
