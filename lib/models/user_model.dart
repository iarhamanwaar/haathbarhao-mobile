// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final List<dynamic>? preferredCategories;
  final List<dynamic>? skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  User({
    this.id,
    this.name,
    this.role,
    this.email,
    this.preferredCategories,
    this.skills,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        preferredCategories: json["preferredCategories"] == null
            ? []
            : List<dynamic>.from(json["preferredCategories"]!.map((x) => x)),
        skills: json["skills"] == null
            ? []
            : List<dynamic>.from(json["skills"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "preferredCategories": preferredCategories == null
            ? []
            : List<dynamic>.from(preferredCategories!.map((x) => x)),
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
