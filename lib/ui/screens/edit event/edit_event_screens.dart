import 'package:evently/firebase_utils/firebase_utility.dart';
import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/models/user_dm.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_dialogs.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/categories_tab_bar.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:evently/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  CategoriesDM selectedCategory = EventDm.currentEvent!.category;
  DateTime selectedDate = EventDm.currentEvent!.dateTime;
 late TimeOfDay selectedTime = TimeOfDay(hour: selectedDate.hour,minute: selectedDate.minute);
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildHeader(),
                      SizedBox(height: MediaQuery.of(context).size.height*.019),
                      Image.asset(
                        selectedCategory.imagePath,
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.019),
                      CategoriesTabBar(
                        categories: AppConstants.categories,
                        onChanged: (category) {
                          selectedCategory = category;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.019),
                      buildEventTextField(titleCtrl, "Title", EventDm.currentEvent!.title),
                      SizedBox(height: MediaQuery.of(context).size.height*.019),
                      buildEventTextField(
                        descCtrl,
                        "Description ",
                        EventDm.currentEvent!.desc,
                        minLine: 4,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.019),
                      buildChooseDate(),
                      buildChooseTime(),
                    ],
                  ),
                ),
              ),
              buildEditEventButton(),
              SizedBox(height: MediaQuery.of(context).size.height*.019),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomContainerButton(
          onClick: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
        ),
        Spacer(),
        Text("Edit event", style: AppTextStyle.black18Medium),
        Spacer(),
      ],
    );
  }

  Widget buildEventTextField(
      TextEditingController ctrl,
      String label,
      String hint, {
        int? minLine,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyle.black16Medium),
        SizedBox(height: MediaQuery.of(context).size.height*.009),
        CustomTextField(
          controller: ctrl,
          hintText: hint,
          minLine: minLine ?? 1,
        ),
      ],
    );
  }

  Widget buildChooseDate() {

    String dateFormat = DateFormat('MMM d, yyyy').format(selectedDate);
    return Row(
      children: [
        Icon(Icons.calendar_month_outlined, color: AppColors.blue),
        SizedBox(width: 8),
        Text("Event Date", style: AppTextStyle.black16Medium),
        Spacer(),
        TextButton(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () async {
            selectedDate =
                await showDatePicker(
                  context: context,
                  firstDate: selectedDate,
                  lastDate: DateTime.now().add(Duration(days: 365)),
                  initialDate: selectedDate,
                ) ??
                    selectedDate;
            setState(() {});
          },
          child: Text(
            dateFormat,
            style: AppTextStyle.blue14Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChooseTime() {
    String timeFormat = DateFormat('h:mm a').format(selectedDate);

    return Row(
      children: [
        Icon(Icons.access_time_outlined, color: AppColors.blue),
        SizedBox(width: 8),
        Text("Event Time", style: AppTextStyle.black16Medium),
        Spacer(),
        TextButton(
          style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () async {
            selectedTime =
                await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                ) ??
                    selectedTime;
            setState(() {});
          },
          child: Text(
           timeFormat ,
            style: AppTextStyle.blue14Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditEventButton() {
    selectedDate=DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
    return CustomButton(
      text: "Update event",
      onPress: () {
        showLoading(context);
         updateEventInFireStore(EventDm.currentEvent!.eventID, selectedCategory, titleCtrl.text.isEmpty?EventDm.currentEvent!.title:titleCtrl.text,  descCtrl.text.isEmpty?EventDm.currentEvent!.desc:descCtrl.text, selectedDate);
         Navigator.pop(context);
         Navigator.pop(context);
         Navigator.pop(context);

      },
    );
  }

}
// EventDm eventDm = EventDm(
//   eventID: "",
//   ownerID:UserDm.currentUser!.id,
//   category: selectedCategory,
//   dateTime: selectedDate,
//   title: titleCtrl.text,
//   desc: descCtrl.text,
//
// );
// await createEventInFirestore(eventDm);