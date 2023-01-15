import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/calendar_widget.dart';

import '../../reusable_widgets/main_appbar.dart';

class AttendancePage extends StatelessWidget {
   AttendancePage({Key? key}) : super(key: key);

   final CalendarController controller = Get.find();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Obx(()=>controller.loading.value ? Center(
        child: SendingLoadingWidget(),
      ) : Column(
        children: [
          MainAppbarWidget("attendance_records",),
          Expanded(child:Column(
            children: [
              Expanded(child: CalendarWidget()),
              Expanded(child: SingleChildScrollView(
                child: Obx(()=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [


                          Container(

                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text('working_time'.tr),

                                  Text(controller.selectedDay.value.day ?? ''),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Expanded(child: Center(child: Text(controller.appController.loginModel.value.timeIn))),
                                      Expanded(child: Center(child: Text(controller.appController.loginModel.value.timeOut))),
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
                              child: Text('${controller.selectedDay.value.status}'.tr,
                                style: TextStyle(
                                    color: AppColors.mainGreenColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      controller.selectedDay.value.attendanceDay != null ?
                      Row(
                        children: [
                          Expanded(child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text('attend'.tr),
                                  Text(controller.selectedDay.value.attendanceTime)
                                ],
                              ),
                            ),)),
                          SizedBox(width: 10,),
                          Expanded(child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text('leaving'.tr),
                                  Text(controller.selectedDay.value.leaveTime)
                                ],
                              ),
                            ),)),
                        ],
                      ) :
                      SizedBox(),

                    ],
                  ),
                )),
              ))
            ],
          )),
        ],
      )),
    );
  }
}
