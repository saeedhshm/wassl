import 'dart:convert';

import 'package:get/get.dart';

import '../../models/attendance/member_attendace_v2.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class MembersAttendanceController extends GetxController{
  final AppController appController = Get.find();
  final _teamAttendance = TeamAttendanceV2().obs;
  var loading = false.obs;

  Future<void> getTeamAttendance() async {
    loading.value = true;
    _teamAttendance.value.teamAttendance.clear();

    if (appController.useMocks) {
      await Future.delayed(const Duration(milliseconds: 400));
      _teamAttendance.value = TeamAttendanceV2.fromJson([
        {
          'id': 1,
          'employee_id': 2,
          'employee': {
            'id': 2,
            'full_name': 'Ahmed Mohammed',
            'full_name_en': 'Ahmed Mohammed',
            'code': 'EMP002',
            'job': {'id': 1, 'name_ar': 'مهندس', 'name_en': 'Engineer'},
          },
          'attendance': [
            {
              'attendance_status': 3,
              'attendance': {
                'id': 1,
                'attendance_time': '2026-05-24 08:00:00',
                'leave_time': '2026-05-24 17:00:00',
              },
            },
          ],
        },
        {
          'id': 2,
          'employee_id': 3,
          'employee': {
            'id': 3,
            'full_name': 'Sarah Ali',
            'full_name_en': 'Sarah Ali',
            'code': 'EMP003',
            'job': {'id': 2, 'name_ar': 'محاسب', 'name_en': 'Accountant'},
          },
          'attendance': [
            {
              'attendance_status': 1,
              'attendance': null,
            },
          ],
        },
      ]);
    } else {
      var headers = {
        'Authorization':
        'bearer ${appController.loginModel.value.token?.accessToken}',
        // "x-localization": 'lang_code'.tr,
      };


      var url = AppUrls.teamAttendanceApi;
      final response = await AppApiHandler.getData(url: url,header: headers,);

      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        _teamAttendance.value = TeamAttendanceV2.fromJson(json);
      }
    }
    loading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTeamAttendance();
  }

  bool get hasTeamMembers{
    return _teamAttendance.value.teamAttendance.isNotEmpty;
  }

  List<MemberAttendance> get teamAttendance {
    return List.from(_teamAttendance.value.teamAttendance);
}

  List<MemberAttendance> get teamAbsence {

    return _teamAttendance.value.teamAttendance.where((MemberAttendance element) => element.memberIsAbsent ).toList() ;
  }
}