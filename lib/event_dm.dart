import 'package:flutter/cupertino.dart';

class EventDm {
  CategoriesDM categoriesDM;
  DateTime date;
  String title;
  String desc;
  bool isFavorite;
  EventDm({
    required this.categoriesDM,
    required this.date,
    required this.title,
    required this.desc,
    required this.isFavorite,
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
