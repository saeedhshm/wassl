import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/controllers/vacations_controller.dart';
import 'package:wassl/getx_controllers/vacations/vacation_view_model.dart';

import '../../helpers/constants/print_ln.dart';
import '../../models/holidays/vacations.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class HolidayDetailsViewModel extends GetxController{

  final AppController appController = Get.find();
  final VacationsController _vacationsController = VacationsController();
  var loading = false.obs;
  var  _vacations = Vacations();

  var incomingVacations = <VacationViewModel>[].obs;
  var previousVacations = <VacationViewModel>[].obs;

  getHolidaysTypes() async {

    loading.value = true;
    // var response = await AppApiHandler.getData(url: AppUrls.getVacations,header: appController.appHeader);
    _vacations = await _vacationsController.getHolidaysTypes(AppUrls.getVacations, appController.appHeader) ?? Vacations() ;
    // if(response.statusCode == 200){
    //   var json = jsonDecode(response.body);
    //   vacations.value = Vacations.fromJson(json);
    // }
    incomingVacations.value = _vacations.data?.nextVacations.map((e) => VacationViewModel(e)).toList() ?? [];
    previousVacations.value = _vacations.data?.previousVacations.map((e) => VacationViewModel(e)).toList() ?? [];
    loading.value = false;

  }




  // dynamic ;
  // dynamic ;
  // dynamic ;

  String get availableVacationsCount{
    return '${_vacations.data?.availableVacationsCount ?? 0}';
  }

  String get usedVacationsCount{
    return '${_vacations.data?.usedVacationsCount ?? 0}';
  }

  String get totalVacationBalance {
    return '${_vacations.data?.openingVacationsCount ?? 0}';
  }

  String get sickVacationsCount {
    return '${_vacations.data?.sickVacationsCount ?? 0}';
  }

  String get unpaidVacationsCount {
    return '${_vacations.data?.unpaidVacationsCount ?? 0}';
  }

  String get discountVacationsCount {
    return '${_vacations.data?.discountVacationsCount ?? 0}';
  }
}