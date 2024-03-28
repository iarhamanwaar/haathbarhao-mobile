// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

List<Task> tasksFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String tasksToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final String? location;
  final String? postedBy;
  final String? assignedTo;
  final String? status;
  final DateTime? date;
  final List<String>? photos;
  final List<String>? requiredSkills;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  Task({
    this.id,
    this.title,
    this.description,
    this.category,
    this.location,
    this.postedBy,
    this.assignedTo,
    this.status,
    this.date,
    this.photos,
    this.requiredSkills,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        location: json["location"],
        postedBy: json["postedBy"],
        assignedTo: json["assignedTo"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        requiredSkills: json["requiredSkills"] == null
            ? []
            : List<String>.from(json["requiredSkills"]!.map((x) => x)),
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
        "title": title,
        "description": description,
        "category": category,
        "location": location,
        "postedBy": postedBy,
        "assignedTo": assignedTo,
        "status": status,
        "date": date?.toIso8601String(),
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "requiredSkills": requiredSkills == null
            ? []
            : List<dynamic>.from(requiredSkills!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
