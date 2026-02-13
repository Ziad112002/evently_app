import 'package:evently/firebase_utils/firebase_utility.dart';
import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/models/user_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(
                  onArrowClick: () {
                    Navigator.pop(context);
                  },
                  onEditClick: () {
                    if (EventDm.currentEvent!.ownerID ==
                        UserDm.currentUser!.id) {
                      Navigator.push(context, AppRoutes.editEvent);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.red,
                          content: Text(
                            "Oops! You can only edit events that you've created.",
                            style: AppTextStyle.white20Medium,
                          ),
                        ),
                        snackBarAnimationStyle: AnimationStyle(
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  onDeleteClick: () {
                    if (EventDm.currentEvent!.ownerID ==
                        UserDm.currentUser!.id) {
                      removeEvent(EventDm.currentEvent!.eventID);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.red,
                          content: Text(
                            "Oops! You can only delete events that you've created.",
                            style: AppTextStyle.white20Medium,
                          ),
                        ),
                        snackBarAnimationStyle: AnimationStyle(
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 16),
                Image.asset(
                  EventDm.currentEvent!.category.imagePath,
                  height: MediaQuery.of(context).size.height * .25,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .019),
                Text(
                  EventDm.currentEvent!.title,
                  style: AppTextStyle.black18Medium,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .019),
                buildDateTimeContainer(),
                SizedBox(height: MediaQuery.of(context).size.height * .019),
                buildDescriptionContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader({
    required void Function()? onArrowClick,
    required void Function()? onEditClick,
    required void Function()? onDeleteClick,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomContainerButton(
          onClick: onArrowClick,
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
        ),
        Spacer(),
        Text("Event Details", style: AppTextStyle.black18Medium),
        Spacer(),
        CustomContainerButton(
          onClick: onEditClick,
          child: ImageIcon(AssetImage(AppAssets.editIcon)),
        ),
        SizedBox(width: 8),
        CustomContainerButton(
          onClick: onDeleteClick,
          child: ImageIcon(
            AssetImage(AppAssets.trashIcon),
            color: AppColors.red,
          ),
        ),
      ],
    );
  }

  Widget buildDateTimeContainer() {
    var date = EventDm.currentEvent!.dateTime;
    String dateFormat = DateFormat('dd MMMM').format(date);
    String timeFormat = DateFormat('h:mm a').format(date);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.whiteBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.calendar_month_outlined, color: AppColors.blue),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(dateFormat, style: AppTextStyle.black16Medium),
              Text(timeFormat, style: AppTextStyle.grey16Medium),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionContainer() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text("Description ", style: AppTextStyle.black16Medium),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            EventDm.currentEvent!.desc,
            style: AppTextStyle.black14Regular,
          ),
        ),
      ],
    );
  }
}
