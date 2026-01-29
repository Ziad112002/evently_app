import 'package:evently/firebase_utils/firebase_utility.dart';
import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/models/user_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/categories_tab_bar.dart';
import 'package:evently/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<EventDm> events = [];
  List<EventDm> filteredEvents = [];
  CategoriesDM selectedCategory = AppConstants.allCategories[0];
  // @override
  // void initState() {
  //   super.initState();
  //   loadData();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            buildHeader(),
            StreamBuilder(
              stream: getEventsFromFireStore(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  events = snapshot.data!;
                  categoryEvent();
                  return Expanded(
                    child: Column(
                      children: [buildCategoriesTabBar(), buildEventList()],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                      mainAxisAlignment: .center,
                      children: [Text(
                      "Error! ${snapshot.error}",
                      style: AppTextStyle.blue24semiBold,
                    ),]
                  );
                } else {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: .center,
                      children: [CircularProgressIndicator()],
                    ),
                  );
                }
              },
            ),
          ],
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
            Text(UserDm.currentUser!.name, style: AppTextStyle.black20Medium),
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
      categories: AppConstants.allCategories,
      onChanged: (category) {
        selectedCategory = category;
        setState(() {});
      },
    );
  }

  Widget buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return EventWidget(event: filteredEvents[index]);
        },
      ),
    );
  }

  void categoryEvent() {
    if (selectedCategory != AppConstants.all) {
      filteredEvents = events.where((event) {
        return event.category.name == selectedCategory.name;
      }).toList();
    } else {
      filteredEvents = events;
    }
  }
}
