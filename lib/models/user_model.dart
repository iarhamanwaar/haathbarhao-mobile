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
  final String? phone;
  final String? preferredCategory;
  final List<Skill>? skills;
  final String? profilePicture;
  final String? location;
  final String? cnicFront;
  final String? cnicBack;
  final bool? isHelper;
  final bool? isHelperSubmitted;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fcmToken;
  final int? v;

  User({
    this.id,
    this.name,
    this.role,
    this.phone,
    this.preferredCategory,
    this.skills,
    this.profilePicture,
    this.location,
    this.cnicFront,
    this.cnicBack,
    this.isHelper,
    this.isHelperSubmitted,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        phone: json["phone"],
        preferredCategory: json["preferredCategory"],
        skills: json["skills"] == null
            ? []
            : List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        profilePicture: json["profilePicture"],
        isHelperSubmitted: json["isHelperSubmitted"],
        location: json["location"],
        cnicFront: json["cnicFront"],
        cnicBack: json["cnicBack"],
        isHelper: json["isHelper"],
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        fcmToken: json["fcmToken"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "phone": phone,
        "preferredCategory": preferredCategory,
        "skills": skills == null
            ? []
            : List<dynamic>.from(skills!.map((x) => x.toJson())),
        "profilePicture": profilePicture,
        "location": location,
        "cnicFront": cnicFront,
        "cnicBack": cnicBack,
        "isHelper": isHelper,
        "isHelperSubmitted": isHelperSubmitted,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "fcmToken": fcmToken,
        "__v": v,
      };
}

class Skill {
  final String name;
  final SkillLevel level;

  Skill({required this.name, required this.level});

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json["name"],
        level: SkillLevel.values
            .firstWhere((e) => e.toString() == 'SkillLevel.${json["level"]}'),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level.toString().split('.').last,
      };

  Skill copyWith({String? name, SkillLevel? level}) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }
}

enum SkillLevel { beginner, intermediate, advanced }
