import 'package:evently/ui/models/event_dm.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_textStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_assets.dart';

class EventWidget extends StatefulWidget {
  final EventDm event;
  const EventWidget({super.key, required this.event});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
   bool isFavorite=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: AppColors.lightGrey, width: 1),
        image: DecorationImage(
          image: AssetImage(widget.event.categoriesDM.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buildContainerDate(), buildDescContainer()],
      ),
    );
  }

  Widget buildContainerDate() {
    String format = DateFormat('dd MMM').format(widget.event.date);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteBlue,
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Text(format, style: AppTextStyle.blue16semiBold),
    );
  }

  Widget buildDescContainer() {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: AppColors.whiteBlue,
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.event.title,
              style: AppTextStyle.black14Medium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {
             isFavorite = !isFavorite;
              setState(() {

              });
            },
            icon: ImageIcon(
              AssetImage(
              isFavorite
                    ? AppAssets.favLogoFill
                    : AppAssets.favLogo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
