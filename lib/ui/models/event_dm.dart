import 'package:flutter/cupertino.dart';

class EventDm {
  CategoriesDM categoriesDM;
  String ownerID;
  DateTime date;
  String title;
  String desc;
  EventDm({
    required this.ownerID,
    required this.categoriesDM,
    required this.date,
    required this.title,
    required this.desc,
  });
}

class CategoriesDM {
  String imagePath;
  String name;
  Icon icon;
  CategoriesDM({
    required this.imagePath,
    required this.name,
    required this.icon,
  });
}
