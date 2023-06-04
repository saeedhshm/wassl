import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../models/attendance/member_attendace.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class MembersAttendanceController extends GetxController{
  final AppController appController = Get.find();
  var teamAttendance = TeamAttendance().obs;
  var loading = false.obs;

  Future<void> getTeamAttendance() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };


    loading.value = true;
    teamAttendance.value.teamAttendance.clear();
    const url = AppUrls.teamAttendanceApi;

    final response = await AppApiHandler.getData(url: url,header: headers,);
    loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      teamAttendance.value = TeamAttendance.fromJson(json);


    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTeamAttendance();
  }

  bool get hasTeamMembers{
    return teamAttendance.value.teamAttendance.isNotEmpty;
  }

}