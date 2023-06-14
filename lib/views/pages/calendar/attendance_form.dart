import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/calendar/widgets/attendance_info.dart';
import 'package:wassl/views/pages/calendar/widgets/calendar_widget.dart';
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
      body: Obx(()=>controller.loading.value ? const Center(
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
      ) : controller.noDataAttendanceAvailable.value == '' ? Column(
        children: [
          MainAppbarWidget("attendance_records",),
          Expanded(child:Column(
            children: [
              CalendarWidget(),
              const SizedBox(height: 16,),
              MonthlyAttendanceInfoWidget()
            ],
          )),
        ],
      ) : Center(
        child: Text(controller.noDataAttendanceAvailable.value.tr),
      )),
    );
  }
}
