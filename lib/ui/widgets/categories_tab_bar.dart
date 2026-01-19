import 'package:evently/event_dm.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:flutter/material.dart';

class CategoriesTabBar extends StatefulWidget {
  final List<CategoriesDM> categories;
  final Function(CategoriesDM category) onChanged;
  const CategoriesTabBar({
    super.key,
    required this.categories,
    required this.onChanged,
  });

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        unselectedLabelColor: AppColors.blue,
        labelColor: AppColors.white,
        indicatorColor: Colors.transparent,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        onTap: (index) {
          selectedTab = index;
          widget.onChanged(widget.categories[index]);

          setState(() {});
        },
        tabs: widget.categories.map(mapCategoriesToWidget).toList(),
      ),
    );
  }

  Widget mapCategoriesToWidget(CategoriesDM category) {
    bool isSelected = selectedTab == widget.categories.indexOf(category);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue : AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: .center,
        children: [
          category.icon,
          SizedBox(width: 8),
          Text(
            category.name,
            style: isSelected
                ? AppTextStyle.white16Medium
                : AppTextStyle.blue16Medium,
          ),
        ],
      ),
    );
  }
}
