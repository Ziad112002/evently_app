import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EventDm {
  CategoriesDM category;
  String eventID;
  String ownerID;
  DateTime dateTime;
  String title;
  String desc;
  EventDm({
    required this.eventID,
    required this.ownerID,
    required this.category,
    required this.dateTime,
    required this.title,
    required this.desc,
  });
  Map<String, dynamic> toJson() {
    return {
      "eventId": eventID,
      "ownerId": ownerID,
      "categories": category.toJson(),
      "dateTime": dateTime,
      "title": title,
      "desc": desc,
    };
  }

  static EventDm fromJson(Map<String, dynamic> json) {
    Timestamp date=json["dateTime"];
    return EventDm(
      eventID: json["eventId"],
      ownerID: json["ownerId"],
      category: CategoriesDM.fromJson(json["categories"]),
      dateTime: date.toDate(),
      title: json["title"],
      desc: json["desc"],
    );
  }
}

class CategoriesDM {
  String imagePath;
  String name;
  IconData icon;
  CategoriesDM({
    required this.imagePath,
    required this.name,
    required this.icon,
  });
  Map<String, dynamic> toJson() {
    return {"imagePath": imagePath, "name": name, "icon": icon.codePoint};
  }

  static CategoriesDM fromJson(Map<String, dynamic> json) {
    int codePoint = json["icon"];
    return CategoriesDM(
      imagePath: json["imagePath"],
      name: json["name"],
      icon: IconData(codePoint),
    );
  }
}
