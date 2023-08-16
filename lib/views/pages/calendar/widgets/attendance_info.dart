import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../orders/pages/correcting_fingerprint.dart';

class MonthlyAttendanceInfoWidget extends StatelessWidget {

  MonthlyAttendanceInfoWidget({Key? key}) : super(key: key);
  final CalendarViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {


    return Obx(()=>Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [

          const SizedBox(height: 16,),
          Stack(
            children: [


              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text('working_time'.tr,style: const TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontSize: 17
                      ),),

                      Text(controller.currentSelectedDate,style: const TextStyle(
                          color: AppColors.darkGreyTextColor,
                          fontSize: 15
                      ),),
                      // SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(child: Center(child: Text(controller.workShiftStartingTime,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontSize: 18
                          ),))),
                          Expanded(child: Center(child: Text(controller.workShiftEndingTime,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontSize: 18
                          ),))),
                        ],
                      )
                    ],
                  ),
                ),
                margin: const EdgeInsets.only(top: 20),
              ),
              Container(
                margin: EdgeInsets.only(right: 'lang'.tr == 'ar' ? 20 : 0,left:'lang'.tr == 'ar' ? 0 : 20 ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6.0,
                        offset: Offset(0.0, 3.0),
                        spreadRadius: 0.0
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 16),
                  child: Text(controller.selectedDateStatus,
                    style: const TextStyle(
                        color: AppColors.mainGreenColor
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          controller.selectedDay.value.attendanceDay != null ?
          Row(
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text('attend'.tr,style: const TextStyle(
                          color: AppColors.darkGreyTextColor,
                          fontSize: 15
                      ),),
                      Text(controller.selectedDateAttendanceTime,style: const TextStyle(
                          color: AppColors.darkGreyTextColor,
                          fontSize: 18
                      ),)
                    ],
                  ),
                ),)),
              const SizedBox(width: 10,),
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)
                ),
                child: InkWell(
                  onTap: (){
                    if(controller.noLeavingRegistered){
                      Get.to(()=> CorrectingFingerprintRequest());
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text('leaving'.tr,style: const TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontSize: 15
                        ),),
                        Text(controller.selectedDateLeaveTime,style: const TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontSize: 18
                        ),)
                      ],
                    ),
                  ),
                ),)),
            ],
          ) :
          const SizedBox(),

        ],
      ),
    ));
  }
}
