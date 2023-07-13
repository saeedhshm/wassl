import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/calendar/widgets/attendance_info.dart';
import 'package:wassl/views/pages/calendar/widgets/calendar_widget.dart';
import 'package:wassl/views/pages/calendar/widgets/table_calendar_widget.dart';
import 'package:wassl/views/pages/home/widgets/attendance_info_widget.dart';

import '../../../helpers/constants/print_ln.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../orders/pages/correcting_fingerprint.dart';

class AttendancePage extends StatelessWidget {
   AttendancePage({Key? key}) : super(key: key);

   final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: Obx(()=>controller.noDataAttendanceAvailable.value == '' ? Column(
        children: [
          MainAppbarWidget("attendance_records",),
          Expanded(child:controller.loading.value ? const Center(
            child: SendingLoadingWidget(),
          ) :controller.noInternetAvailable.value != '' ? Center(
            child: InkWell(
              onTap: (){
                controller.retrieveAttendanceData();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.noInternetAvailable.value),
                  Text('tap_to_refresh'.tr),
                  const Icon(Icons.refresh,size: 40,color: Colors.blue,),
                ],
              ),
            ),
          ) : SingleChildScrollView(child: Column(
            children: [
              Column(
                children: [
                  // CalendarWidget(),
                  TableCalendarWidget(),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(child: Container(
                        // height: Get.width / 3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              const Text('1',style: TextStyle(
                                  color: AppColors.orangeColorInCalend,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('absent'.tr,style: const TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontSize: 15
                              ),)
                            ],
                          ),
                        ),

                      )),
                      const SizedBox(width: 8,),
                      Expanded(child: Container(
                        // height: Get.width / 3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              Text('1',style: TextStyle(
                                  color: AppColors.purpleLateColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('delay'.tr,style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontSize: 15
                              ),)
                            ],
                          ),
                        ),

                      )),
                      const SizedBox(width: 8,),
                      Expanded(child: Container(
                        // height: Get.width / 3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              Text('1',style: TextStyle(
                                  color: AppColors.yellowEarlyExitColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('early_leave'.tr,style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontSize: 15
                              ),)
                            ],
                          ),
                        ),

                      )),
                      const SizedBox(width: 8,),
                      Expanded(child: Container(
                        // height: Get.width / 3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              Text('1',style: TextStyle(
                                  color: AppColors.redMissedDayColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('missed_leave'.tr,style: TextStyle(
                                  color: AppColors.lightGreyTextColor,
                                  fontSize: 15
                              ),)
                            ],
                          ),
                        ),

                      )),
                    ],
                  ),
                ],
              ),
              MonthlyAttendanceInfoWidget(),
              SizedBox(height: 100,)
            ],
          ),)),
        ],
      ) : Center(
        child: Text(controller.noDataAttendanceAvailable.value.tr),
      )),
    );
  }
}
