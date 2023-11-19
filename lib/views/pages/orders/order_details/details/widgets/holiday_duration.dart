import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../../models/orders/holiday.dart';

class HolidayDurationWidget extends StatelessWidget {

  HolidayDurationWidget({super.key});
  final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return (controller.order is HolidaysData) ?   Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            height: 1,
            color: AppColors.borderTextFieldColor,
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  child: Image.asset('assets/images/order_details/calendar.png'),
                ),
                const SizedBox(width: 16,),
                Text('holiday_time'.tr,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                const Spacer(),

                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(((controller.order as HolidaysData).differenceInDays),style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontSize: 12
                    ),),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            height: 1,
            color: AppColors.borderTextFieldColor,
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Spacer(),
                Text(((controller.order as HolidaysData).holidayStart ?? ''),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                const SizedBox(width: 16,),
                SizedBox(
                  width: 25,
                  child: Image.asset('assets/images/order_details/arrow.png'),
                ),
                const SizedBox(width: 16,),
                Text(((controller.order as HolidaysData).holidayEnd ?? ''),style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontWeight: FontWeight.bold
                ),),
                const Spacer(),


              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: double.maxFinite,
            height: 1,
            color: AppColors.borderTextFieldColor,
          ),
        ),
      ],
    ) : const SizedBox();
  }
}
