import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:wassl/features/home/data/repositories/location_failurs.dart';
import 'package:wassl/features/home/domain/use_cases/attendance_use_case.dart';
import 'package:wassl/features/home/presentation/manager/status/attendance_state.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/extensions/date_time.dart';
import 'package:wassl/models/ads/ads.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../../../getx_controllers/calendar/calendar_controller.dart';
import '../../../../models/events/events.dart';
import '../../../../web_services_helper/api.dart';
import '../../data/models/attendance_check.dart';
import '../../domain/use_cases/location_use_case.dart';

class HomeController extends GetxController {
  final LocationUseCase locationUseCase;
  final AttendanceUseCases attendanceUseCases;

  HomeController(
      {required this.locationUseCase, required this.attendanceUseCases});

  Rx<AttendanceState> homeAttendanceStatus = Rx(AttendanceInitState());
  // Rx<AttendanceStatusState> attendanceStatusState =
  //     Rx(AttendanceStatusInitState());

  final AppController appController = Get.find();

  var sendingAttendance = false.obs;
  var employeesHasTowShifts = false.obs;

  var attendanceStatus = 1.obs;
  List<AttendanceCheck> checkList = [];
  var currentShift = AttendanceCheck().obs;

  final CalendarViewModel calendarController = Get.find();

  var dt = DateTime.now().obs;

  var events = IncomingEvents().obs;
  var nextEventsLoading = false.obs;

  var ads = AppAds().obs;
  var appAdsLoading = false.obs;

  // page :- apis retriever
  Future<String> registerAttendance({String? bearer}) async {
    sendingAttendance.value = true;
    var body = {
      'longitude': '${appController.position?.longitude}',
      'latitude': '${appController.position?.latitude}',
      'schedule_id': '${currentShift.value.schedule?.scheduleId}'
    };

    var headers = {
      'Authorization':
          'bearer ${bearer ?? appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    var url = '';
    if (attendanceStatus.value == 2) {
      url = AppUrls.leaving;
    } else {
      url = AppUrls.attendance;
    }

    final response =
        await AppApiHandler.postData(url: url, body: body, header: headers);

    sendingAttendance.value = false;

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      if (json['success'] == true) {
        attendanceStatus.value = attendanceStatus.value == 2 ? 3 : 2;
        calendarController.retrieveAttendanceData();
        if (attendanceStatus.value == 2) {
          return 'attendance_done_successfully'.tr;
        } else {
          return 'leaving_done_successfully'.tr;
        }
      } else {
        Future.error(json['message']);
      }
    }
    return Future.error(
        '${response.body}\n${appController.position?.longitude},${appController.position?.latitude}');
  }

  checkForAttendance() async {
    var headers = {
      'Authorization':
          'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    var eitherResult = await attendanceUseCases.checkAttendanceStatus(headers);

    eitherResult.fold((l) {}, (r) {
      currentShift.value = r;
    });

    attendanceStatus.value = currentShift.value.attendanceStatus ?? 0;
    if (currentShift.value.attendance != null) {
      if (attendanceStatus.value == 1) {
        if (DateTime.now().isAfter(currentShift.value.empTimeIn) &&
            DateTime.now().isBefore(currentShift.value.empAllowTimeOut)) {
          attendanceStatus.value = 2;
        } else {
          attendanceStatus.value = 1;
        }
      }
    }
  }

  Future getIncomingEvents() async {
    nextEventsLoading.value = true;
    var response = await AppApiHandler.getData(
        url: AppUrls.meetingsApi, header: appController.appHeader);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      events.value = IncomingEvents.fromJson(json);
    }
    nextEventsLoading.value = false;
  }

  Future getAppAds() async {
    appAdsLoading.value = true;
    var response = await AppApiHandler.getData(
        url: AppUrls.adsApi, header: appController.appHeader);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      ads.value = AppAds.fromJson(json);
    }
    appAdsLoading.value = false;
  }

  String get currentTime {
    return dt.value.timeIn12Hours;
  }

  String get currentShiftTimeIn {
    return currentShift.value.schedule?.timeIn ?? '';
  }

  String get currentShiftTimeOut {
    return currentShift.value.schedule?.timeOut ?? '';
  }

  String get branchName {
    return appController.loginModel.value.user!.branch?.name ?? '';
  }

  String get currentShiftTitle {
    if (currentShift.value.haseTowShifts) {
      return 'working_period'.trParams({
        'name': currentShift.value.shiftIndex == 0 ? 'first'.tr : 'second'.tr
      });
    }
    return 'working_period'.trParams({'name': ''});
  }

  //controller lifecycle
  @override
  void onInit() {
    super.onInit();
    if (appController.isFingerPrintExempt) {
      homeAttendanceStatus.value = AttendanceFingerPrintExceptionState();
    } else if (appController.isHolidayDay) {
      homeAttendanceStatus.value = AttendanceHolidayState();
    } else {
      getUserLocationPermission();
    }
    final detroit = tz.getLocation('Asia/Riyadh');

    checkForAttendance();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      dt.value = tz.TZDateTime.from(DateTime.now(), detroit);
    });
    appController.getHolidaysData();
    getIncomingEvents();
    getAppAds();
  }

  reEnableLocationServices() async {
    await getUserLocationPermission();
    if (homeAttendanceStatus.value is HomeLocationDeniedForeverState) {
      await Geolocator.openAppSettings();
    }
  }

  String get attendanceStatusValue {
    return attendanceStatus.value == 0
        ? 'today_holiday'.tr
        : attendanceStatus.value == 1
            ? 'reg_attend'.tr
            : attendanceStatus.value == 2
                ? 'reg_leaving'.tr
                : 'shift_done'.tr;
  }

  bool get attendanceRegisterBlocker {
    return attendanceStatus.value == 0 ||
        attendanceStatus.value == 3 ||
        sendingAttendance.value;
  }

  Future getUserLocationPermission() async {
    homeAttendanceStatus.value = AttendanceLoadingState();
    var eitherResult = await locationUseCase.checkLocationPermission();

    eitherResult.fold((failure) {
      println(failure);
      if (failure is LocationDeniedFailure) {
        homeAttendanceStatus.value = HomeLocationDeniedState();
      } else if (failure is LocationDeniedForeverFailure) {
        homeAttendanceStatus.value = HomeLocationDeniedForeverState();
      } else {
        // system location disable
        homeAttendanceStatus.value = HomeLocationSystemDisabledState();
      }
    }, (r) {
      homeAttendanceStatus.value = HomeLocationEnabledState();
    });
  }
}
