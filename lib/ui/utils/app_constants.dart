import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:flutter/material.dart';

abstract final class AppConstants {
  static CategoriesDM all = CategoriesDM(
    imagePath: "",
    name: "All",
    icon: Icon(Icons.category),
  );
  static CategoriesDM sport = CategoriesDM(
    imagePath: AppAssets.sportLight,
    name: "Sport",
    icon: Icon(Icons.directions_bike_outlined),
  );
  static CategoriesDM bookingClub = CategoriesDM(
    imagePath: AppAssets.bookClubLight,
    name: "Booking Club",
    icon: Icon(Icons.menu_book),
  );
  static CategoriesDM birthday = CategoriesDM(
    imagePath: AppAssets.birthdayLight,
    name: "Birthday",
    icon: Icon(Icons.cake_outlined),
  );
  static CategoriesDM meeting = CategoriesDM(
    imagePath: AppAssets.meetingLight,
    name: "Meeting",
    icon: Icon(Icons.meeting_room),
  );
  static CategoriesDM exhibition = CategoriesDM(
    imagePath: AppAssets.exhibitionLight,
    name: "Exhibition",
    icon: Icon(Icons.menu),
  );
  static List<CategoriesDM> allCategories = [
    all,
    sport,
    bookingClub,
    birthday,
    meeting,
    exhibition,
  ];
  static List<CategoriesDM> categories = [
    sport,
    bookingClub,
    birthday,
    meeting,
    exhibition,
  ];
  static const String displayOnboarding="onBoarding";
  static bool? showOnboarding;
}
