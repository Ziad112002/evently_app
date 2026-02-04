import 'package:evently/ui/models/user_dm.dart';
import 'package:evently/ui/providers/language_provider.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late LanguageProvider provider;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .13,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.profile),
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .018),
            Text(
              UserDm.currentUser!.name,
              style: AppTextStyle.black20semiBold,
              textAlign: TextAlign.center,
            ),
            Text(
              UserDm.currentUser!.email,
              style: AppTextStyle.darkGrey14Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .039),
            buildDarkModeContainer(),
            SizedBox(height: MediaQuery.of(context).size.height * .018),
            buildSelectLanguageContainer(),
            SizedBox(height: MediaQuery.of(context).size.height * .018),
            buildLogoutContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildDarkModeContainer() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Text("Dark mode", style: AppTextStyle.black16Medium),
        Spacer(),
        Transform.scale(
          scale: .8,
          child: Switch(
            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
            inactiveTrackColor: Color(0xffE9EAEB),
            inactiveThumbColor: AppColors.white,
            activeTrackColor: AppColors.blue,
            activeThumbColor: AppColors.white,
            value: false,
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );

  Widget buildSelectLanguageContainer() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Text("Language", style: AppTextStyle.black16Medium),
        Spacer(),
        Transform.scale(
          scale: .8,
          child: Switch(
            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
            inactiveTrackColor: Color(0xffE9EAEB),
            inactiveThumbColor: AppColors.white,
            activeTrackColor: AppColors.blue,
            activeThumbColor: AppColors.white,
            value: provider.currentLocale=="ar",
            onChanged: (value) {
              provider.updateLocale(value?"ar":"en");
            },
          ),
        ),
      ],
    ),
  );

  Widget buildLogoutContainer() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Text("Logout", style: AppTextStyle.black16Medium),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.logout, color: AppColors.red),
        ),
      ],
    ),
  );
}
