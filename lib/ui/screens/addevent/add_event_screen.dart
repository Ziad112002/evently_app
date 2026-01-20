import 'package:evently/event_dm.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_constants.dart';
import 'package:evently/ui/utils/app_textstyle.dart';
import 'package:evently/ui/widgets/categories_tab_bar.dart';
import 'package:evently/ui/widgets/custom_button.dart';
import 'package:evently/ui/widgets/custom_container_button.dart';
import 'package:evently/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoriesDM selectedCategory = AppConstants.categories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteBlue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildHeader(),
                      SizedBox(height: 16),
                      Image.asset(
                        selectedCategory.imagePath,
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      SizedBox(height: 16),
                      CategoriesTabBar(
                        categories: AppConstants.categories,
                        onChanged: (category) {
                          selectedCategory = category;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 16),
                      buildEventTextField(label: "Title", hint: "Event Title"),
                      SizedBox(height: 16),
                      buildEventTextField(
                        label: "Description ",
                        hint: "Event Description",
                        minLine: 4,
                      ),
                      SizedBox(height: 16),
                      buildChooseDate(),
                      buildChooseTime(),
                    ],
                  ),
                ),
              ),
              buildAddEventButton()
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
          widget: Icon(Icons.arrow_back_ios_new, color: AppColors.blue),
        ),
        Spacer(),
        Text("Add event", style: AppTextStyle.black18Medium),
        Spacer(),
      ],
    );
  }

  Widget buildEventTextField({
    required String label,
    required String hint,
    int? minLine,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppTextStyle.black16Medium),
        SizedBox(height: 8),
        CustomTextField(hintText: hint, minLine: minLine ?? 1),
      ],
    );
  }

  Widget buildChooseDate() {
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
            "Choose date",
            style: AppTextStyle.blue14Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildChooseTime() {
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
            "Choose time",
            style: AppTextStyle.blue14Regular.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
  Widget buildAddEventButton(){
    return CustomButton(text: "Add Event", onPress: (){

    });
  }
}
