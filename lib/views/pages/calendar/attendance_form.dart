import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/calendar/calendar_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/calendar/widgets/attendance_info.dart';
import 'package:wassl/views/pages/calendar/widgets/month_report.dart';
import 'package:wassl/views/pages/calendar/widgets/table_calendar_widget.dart';
import '../../reusable_widgets/main_appbar.dart';

class AttendancePage extends StatelessWidget {
  AttendancePage({Key? key}) : super(key: key);

  final CalendarViewModel controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: Column(
              children: [
                MainAppbarWidget(
                  "attendance_records",
                ),
                Expanded(
                    child:SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        // CalendarWidget(),
                                        const TableCalendarWidget(),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        MonthReportWidget(),
                                      ],
                                    ),
                                    MonthlyAttendanceInfoWidget(),
                                    const SizedBox(
                                      height: 100,
                                    )
                                  ],
                                ),
                              )),
              ],
            )

    );
  }
}
