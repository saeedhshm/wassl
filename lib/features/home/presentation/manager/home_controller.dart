import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:wassl/features/home/data/repositories/location_failurs.dart';
import 'package:wassl/features/home/domain/use_cases/attendance_use_case.dart';
import 'package:wassl/features/home/presentation/manager/status/attendance_status_state.dart';
import 'package:wassl/features/home/presentation/manager/status/location_state.dart';
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

Map<String, dynamic> _mockAdsJson = {
  'success': true,
  'advertisements': [
    {
      'id': 1,
      'title': 'Company Annual Meeting',
      'description': 'Join us for the annual company meeting where we will discuss our achievements and future plans.',
      'image': '',
      'status': 1,
      'start_date': '2026-06-01',
      'end_date': '2026-06-01',
      'created_at': '2026-05-01',
      'updated_at': '2026-05-01',
    },
    {
      'id': 2,
      'title': 'Health Insurance Update',
      'description': 'New health insurance plans available for all employees. Check your eligibility now.',
      'image': '',
      'status': 1,
      'start_date': '2026-06-15',
      'end_date': '2026-07-15',
      'created_at': '2026-05-15',
      'updated_at': '2026-05-15',
    },
  ],
};

Map<String, dynamic> _mockEventsJson = {
  'success': true,
  'covenants': [
    {
      'id': 1,
      'title': 'Team Building Workshop',
      'description': 'An interactive workshop to improve team collaboration and communication skills.',
      'status': 1,
      'start_date': '2026-06-10T10:00:00.000',
      'end_date': '2026-06-10T15:00:00.000',
      'created_at': '2026-05-20T00:00:00.000',
      'updated_at': '2026-05-20T00:00:00.000',
      'location': 'Conference Room A',
    },
    {
      'id': 2,
      'title': 'Quarterly Review',
      'description': 'Q2 performance review meeting with department heads.',
      'status': 1,
      'start_date': '2026-07-01T09:00:00.000',
      'end_date': '2026-07-01T12:00:00.000',
      'created_at': '2026-06-01T00:00:00.000',
      'updated_at': '2026-06-01T00:00:00.000',
      'location': 'Main Hall',
    },
    {
      'id': 3,
      'title': 'Training Session',
      'description': 'Mandatory training session on new company policies.',
      'status': 1,
      'start_date': '2026-06-20T08:00:00.000',
      'end_date': '2026-06-20T16:00:00.000',
      'created_at': '2026-06-05T00:00:00.000',
      'updated_at': '2026-06-05T00:00:00.000',
      'location': 'Training Room B',
    },
  ],
};

class HomeController extends GetxController {
  final LocationUseCase locationUseCase;
  final AttendanceUseCases attendanceUseCases;

  HomeController(
      {required this.locationUseCase, required this.attendanceUseCases});

  Rx<LocationState> locationState = Rx(LocationLoadingState());
  Rx<AttendanceStatusState> attendanceStatusState =
      Rx(AttendanceStatusInitState());

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
    locationState.value = LocationLoadingState();
    var either = await locationUseCase.getUserLocationPosition();
    either.fold((l) {
      locationState.value = LocationDeniedForeverState();
      return '';
    }, (position) async {
      var body = {
        'longitude': '${position.longitude}',
        'latitude': '${position.latitude}',
        'schedule_id': '${currentShift.value.schedule?.scheduleId}'
      };

      var header = {
        'Authorization':
            'bearer ${bearer ?? appController.loginModel.value.token?.accessToken}',
        // "x-localization": 'lang_code'.tr,
      };

      var url = AppUrls.registerAttendance(attendanceStatus.value);

      var eitherAttend = await attendanceUseCases.registerAttendanceLeave(
          url: url, body: body, header: header);
      locationState.value = LocationEnabledState();
      eitherAttend.fold((failure) {
        println('=-==-=-=-=-= $failure');
        // lo
      }, (r) {
        println("=-=-=->>>>3 ${attendanceStatus.value}");
        attendanceStatus.value = attendanceStatus.value == 2 ? 3 : 2;
        calendarController.retrieveAttendanceData();
        if (attendanceStatus.value == 2) {
          return 'attendance_done_successfully'.tr;
        } else {
          return 'leaving_done_successfully'.tr;
        }
      });

      sendingAttendance.value = false;
    });
    return '';
  }

  checkForAttendance() async {
    if (appController.useMocks) {
      await Future.delayed(const Duration(milliseconds: 300));
      currentShift.value = AttendanceCheck.fromJson({
        'attendance_status': 2,
        'attendance': {
          'id': 1,
          'attendance_time': '${DateTime.now().toIso8601String().split('T')[0]} 08:00:00',
          'leave_time': '${DateTime.now().toIso8601String().split('T')[0]} 17:00:00',
        },
        'schedule': {
          'id': 1,
          'time_in': '08:00:00',
          'time_out': '17:00:00',
          'allow_time_in': '08:30:00',
          'allow_time_out': '17:40:00',
          'info': {
            'id': 1,
            'time_in': '08:00:00',
            'time_out': '17:00:00',
            'week_end_days': '5,6',
          },
        },
      });
      attendanceStatus.value = 2;
    } else {
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
  }

  Future getIncomingEvents() async {
    nextEventsLoading.value = true;
    if (appController.useMocks) {
      await Future.delayed(const Duration(milliseconds: 400));
      events.value = IncomingEvents.fromJson(_mockEventsJson);
    } else {
      var response = await AppApiHandler.getData(
          url: AppUrls.meetingsApi, header: appController.appHeader);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        events.value = IncomingEvents.fromJson(json);
      }
    }
    nextEventsLoading.value = false;
  }

  Future getAppAds() async {
    appAdsLoading.value = true;
    if (appController.useMocks) {
      await Future.delayed(const Duration(milliseconds: 400));
      ads.value = AppAds.fromJson(_mockAdsJson);
    } else {
      var response = await AppApiHandler.getData(
          url: AppUrls.adsApi, header: appController.appHeader);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        ads.value = AppAds.fromJson(json);
      }
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
    appInit();
  }

  appInit() async {
    if (appController.isFingerPrintExempt) {
      attendanceStatusState.value = AttendanceFingerPrintExceptionState();
    } else if (appController.isHolidayDay) {
      attendanceStatusState.value = AttendanceHolidayState();
    } else {
      await getUserLocationPermission();
    }
    await checkForAttendance();
    final detroit = tz.getLocation('Asia/Riyadh');
    Timer.periodic(const Duration(seconds: 1), (timer) {
      dt.value = tz.TZDateTime.from(DateTime.now(), detroit);
    });
    appController.getHolidaysData();
    getIncomingEvents();
    getAppAds();
  }

  reEnableLocationServices() async {
    await getUserLocationPermission();
    if (locationState.value is LocationDeniedForeverState) {
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
    locationState.value = LocationLoadingState();
    var eitherResult = await locationUseCase.checkLocationPermission();

    eitherResult.fold((failure) {
      println(failure);
      if (failure is LocationDeniedFailure) {
        locationState.value = LocationDeniedState();
      } else if (failure is LocationDeniedForeverFailure) {
        locationState.value = LocationDeniedForeverState();
      } else {
        // system location disable
        locationState.value = LocationSystemDisabledState();
      }
    }, (r) {
      locationState.value = LocationEnabledState();
    });
  }
}
