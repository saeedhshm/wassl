import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../models/holidays/vacations.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class HolidayDetailsController extends GetxController{

  final AppController appController = Get.find();
  var loading = false.obs;
  var vacations = Vacations().obs;

  getHolidaysTypes() async {

    loading.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getVacations,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      vacations.value = Vacations.fromJson(json);
    }
    loading.value = false;
    println(response.statusCode);
    println(response.body);
  }
}