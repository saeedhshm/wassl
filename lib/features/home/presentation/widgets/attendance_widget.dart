import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/exceptions/internet_api_exceptions.dart';

import '../../../../features/home/presentation/manager/home_controller.dart';
import '../../../../features/home/presentation/manager/status/location_state.dart';
import '../../../../features/home/presentation/widgets/attendance/widgets/attendance_message.dart';
import '../../../../features/home/presentation/widgets/attendance/widgets/message_widget.dart';
import '../../../../getx_controllers/app_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../views/consts_widgets/loading_widgets.dart';
import '../../../../views/reusable_widgets/dialogs_messages/snack_bars.dart';
import '../manager/status/attendance_status_state.dart';
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
        if (controller.attendanceStatusState.value
            is AttendanceFingerPrintExceptionState) {
          return AttendanceMessageWidget('exempt'.tr);
        }
        if (controller.attendanceStatusState.value is AttendanceHolidayState) {
          return AttendanceMessageWidget('today_holiday'.tr);
        }
        switch (controller.locationState.value.runtimeType) {
          case LocationLoadingState:
            return const SendingLoadingWidget();
          case LocationEnabledState:
            return IgnorePointer(
              // ignoring: controller.attendanceRegisterBlocker,
              ignoring: false,
              child: AttendanceInfoWidget(),
            );
          case LocationDeniedState:
            return AttendanceLocationErrorMessageWidget(
              'must_enable_location'.tr,
            );
          case LocationDeniedForeverState:
            return AttendanceLocationErrorMessageWidget(
              'must_enable_location'.tr,
            );
          case LocationSystemDisabledState:
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
