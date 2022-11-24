import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/calendar_widget.dart';

import '../../reusable_widgets/main_appbar.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Column(
        children: [
          MainAppbarWidget("attendance_records",),
          Expanded(child: Column(
            children: [
              Expanded(child: CalendarWidget()),
              Expanded(child: SingleChildScrollView(
                child: Padding(
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
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Expanded(child: Center(child: Text('7:00 ص'))),
                                      Expanded(child: Center(child: Text('3:00 م'))),
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
                              child: Text('attending'.tr,
                                style: TextStyle(
                                  color: AppColors.mainGreenColor
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
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
                                Text('7:00 ص'.tr)
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
                                  Text('3:00 م'.tr)
                                ],
                              ),
                            ),)),
                        ],
                      )
                    ],
                  ),
                ),
              )),
            ],
          )),
        ],
      ),
    );
  }
}
