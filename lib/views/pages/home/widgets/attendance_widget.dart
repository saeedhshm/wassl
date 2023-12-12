import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';

import '../../../../features/home/presentation/manager/home_controller.dart';
import '../../../../features/home/presentation/manager/status/attendance_state.dart';
import '../../../../features/home/presentation/widgets/attendance/widgets/attendance_message.dart';
import '../../../../features/home/presentation/widgets/attendance/widgets/message_widget.dart';
import '../../../../getx_controllers/app_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/print_ln.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/dialogs_messages/snack_bars.dart';
import 'attendance_info_widget.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({Key? key}) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  final HomeController controller = Get.find();

  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      // !appController.isHolidayDay ?
      child: Obx(() {
        switch (controller.homeAttendanceStatus.value.runtimeType) {
          case AttendanceLoadingState:
            return const SendingLoadingWidget();
          case AttendanceFingerPrintExceptionState:
            return AttendanceMessageWidget('exempt'.tr);
          case AttendanceHolidayState:
            return AttendanceMessageWidget('today_holiday'.tr);
          case HomeLocationEnabledState:
            return IgnorePointer(
              ignoring: controller.attendanceStatus.value == 0 ||
                  controller.attendanceStatus.value == 3 ||
                  controller.sendingAttendance.value,
              // ignoring: false,
              child: InkWell(
                onTap: () async {
                  println(appController.isHolidayDay);
                  // return;
                },
                child: AttendanceInfoWidget(),
              ),
            );
          case HomeLocationDeniedState:
            return AttendanceLocationErrorMessageWidget(
              'must_enable_location'.tr,
            );
          case HomeLocationDeniedForeverState:
            return AttendanceLocationErrorMessageWidget(
              'must_enable_location'.tr,
            );
          case HomeLocationSystemDisabledState:
            return AttendanceLocationErrorMessageWidget(
              'must_enable_location_in_system'.tr,
            );
          default:
            return Text('nothing_from the above'.tr,
                style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold));
        }
      }),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 0,
          )
        ],
      ),
    );
  }

  Future<void> attend() async {
    Get.back();
    try {
      var attendanceDone = await controller.registerAttendance();
      SnackBars.showConfirmedSnackBar('success'.tr, attendanceDone);
    } on NoInternetException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    } catch (exception) {
      var errorMessage = 'something_wrong_try_again'.tr;
      SnackBars.showErrorSnackBar('error'.tr, exception.toString());
    } finally {
      controller.sendingAttendance.value = false;
    }
  }
}
