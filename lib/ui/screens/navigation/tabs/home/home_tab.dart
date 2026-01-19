import 'package:evently/event_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/categories_tab_bar.dart';
import 'package:evently/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [buildHeader(), buildCategoriesTabBar(), buildEventList()],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back ✨",
              style: AppTextStyle.darkGrey14Regular,
              textAlign: TextAlign.start,
            ),
            Text("Ziad Hammad", style: AppTextStyle.black20Medium),
          ],
        ),
        Spacer(),
        ImageIcon(AssetImage(AppAssets.lightModeLogo), color: AppColors.blue),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("EN", style: AppTextStyle.white14semiBold),
        ),
      ],
    );
  }

  Widget buildCategoriesTabBar() {
    return CategoriesTabBar(
      categories: AppConstants.categories,
      onChanged: (category) {
      },
    );
  }

  Widget buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          CategoriesDM category = CategoriesDM(
            imagePath: AppAssets.bookClubLight,
            name: "Reading Book",
            icon: Icon(Icons.menu_book_outlined),
          );
          EventDm event = EventDm(
            categoriesDM: category,
            date: DateTime.now(),
            title: "This is a Birthday Party  ",
            desc: "Meeting for Updating The Development Method ",
            isFavorite: false,
          );
          return EventWidget(event: event);
        },
      ),
    );
  }
}
