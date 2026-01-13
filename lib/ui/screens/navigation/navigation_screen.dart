import 'package:evently/ui/screens/navigation/tabs/favorite/favorite_tab.dart';
import 'package:evently/ui/screens/navigation/tabs/home/home_tab.dart';
import 'package:evently/ui/screens/navigation/tabs/profile/profile_tab.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;
  List tabs=[
    HomeTab(),
    FavoriteTab(),
    ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      floatingActionButton: buildFAB(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs[selectedIndex],
    );
  }

  Widget buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.blue,
      shape: CircleBorder(),
      child: Icon(Icons.add, color: AppColors.white),
    );
  }

  Widget buildBottomNavigationBar() {
    return Theme(
      data: ThemeData(canvasColor: AppColors.white),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.grey,
          currentIndex: selectedIndex,
          onTap: (int currentIdx) {
            selectedIndex = currentIdx;
            setState(() {});
          },
          items: [
            buildBottomNavigationBarItem(
              "Home",
              selectedIndex == 0
                  ? ImageIcon(AssetImage(AppAssets.homeLogoFill))
                  : ImageIcon(AssetImage(AppAssets.homeLogo)),
            ),
            buildBottomNavigationBarItem(
              "Favorite",
              selectedIndex == 1
                  ? ImageIcon(AssetImage(AppAssets.favLogoFill))
                  : ImageIcon(AssetImage(AppAssets.favLogo)),
            ),
            buildBottomNavigationBarItem(
              "Profile",
              selectedIndex == 2
                  ? ImageIcon(AssetImage(AppAssets.personLogoFill))
                  : ImageIcon(AssetImage(AppAssets.personLogo)),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
    String label,
    Widget icon,
  ) => BottomNavigationBarItem(label: label, icon: icon);
}
