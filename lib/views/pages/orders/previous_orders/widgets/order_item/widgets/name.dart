import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../helpers/constants/app_colors.dart';

class EmpNameWidget extends StatelessWidget {

  final String? nameEmployee;
  const EmpNameWidget({this.nameEmployee,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return nameEmployee != null ? Row(
      children: [
        Text('emp_name'.tr + ' : ' ,style: const TextStyle(
            color: AppColors.darkGreyTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 13
        ),),
        SizedBox(),
        Text(nameEmployee ?? '' ,style: const TextStyle(
            color: AppColors.darkGreyTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 13
        ),),
      ],
    ) : SizedBox();
  }
}
