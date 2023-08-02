import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/constants/app_colors.dart';

class MonthReportWidget extends StatelessWidget {
  const MonthReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemWidget(
          numberCount: 2,
          numberColor: AppColors.orangeColorInCalend,
          type: 'absent'.tr,
        ),
        ItemWidget(
          numberCount: 3,
          numberColor: AppColors.purpleLateColor,
          type: 'delay'.tr,
        ),
        ItemWidget(
          numberCount: 4,
          numberColor: AppColors.yellowEarlyExitColor,
          type: 'early_leave'.tr,
        ),
        ItemWidget(
          numberCount: 5,
          numberColor: AppColors.redMissedDayColor,
          type: 'missed_leave'.tr,
        ),
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {

  final int numberCount;
  final String type;
  final Color numberColor;
  const ItemWidget({
    Key? key,
    required this.type,
    required this.numberColor,
    required this.numberCount
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      height: Get.width / 4.5,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text('$numberCount',style: TextStyle(
                color: numberColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            Text(type,style: const TextStyle(
                color: AppColors.lightGreyTextColor,
                fontSize: 13
            ),)
          ],
        ),
      ),

    ));
  }
}