import 'package:evently/firebase_utils/firebase_utility.dart';
import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/custom_text_field.dart';
import 'package:evently/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  List<EventDm> events = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            buildHeader(),
            SizedBox(height: 16),
            FutureBuilder(
              future: getFavouriteEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  events = snapshot.data!;
                  return buildEventList(events);
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Error! ${snapshot.error}",
                        style: AppTextStyle.blue24semiBold,
                      ),
                    ],
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
    return CustomTextField(
      hintText: "Search for event",
      suffixIcon: Icon(Icons.search),
    );
  }

  Widget buildEventList(List<EventDm> events) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventWidget(
            event: events[index],
            onTap: () {
              EventDm.currentEvent = events[index];
              Navigator.push(context, AppRoutes.eventDetails);
            },
          );
        },
      ),
    );
  }
}
