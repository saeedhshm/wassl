import 'package:flutter/material.dart';

import '../../../../../helpers/constants/app_colors.dart';


class TabWidget extends StatelessWidget {
  const TabWidget({
    Key? key,
    required this.title,
    required this.tabSelected,
  }) : super(key: key);

  final bool tabSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:tabSelected ? AppColors.mainGreenColor : AppColors.borderTextFieldColor,width: 1))
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,style: TextStyle(
              color: tabSelected ? AppColors.mainGreenColor : AppColors.darkGreyTextColor
          ),),
        ),
      ),
    );
  }
}