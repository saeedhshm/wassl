import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class MonthReportWidget extends StatelessWidget {

  final CalendarViewModel controller = Get.find();

  MonthReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemWidget(
          numberCount: controller.countWorkDaysAbsent,
          numberColor: AppColors.iconsColor,
          type: 'absent'.tr,
        ),
        ItemWidget(
          numberCount: controller.lateAttendanceCount,
          numberColor: AppColors.purpleLateColor,
          type: 'delay'.tr,
        ),
        ItemWidget(
          numberCount: controller.earlyLeaveCount,
          numberColor: AppColors.yellowEarlyExitColor,
          type: 'early_leave'.tr,
        ),
        ItemWidget(
          numberCount: controller.missedRecordsCount,
          numberColor: AppColors.redMissedDayColor,
          type: 'missed_leave'.tr,
        ),
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {

  final String numberCount;
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