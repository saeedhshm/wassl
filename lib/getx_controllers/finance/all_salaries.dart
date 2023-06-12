import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/models/finance/salaries.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class AllSalariesController extends GetxController{
  final AppController appController = Get.find();
  var loading = false.obs;

  var allSalaries = Salaries();


  Future<void> _getAllSalaries() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };


    loading.value = true;

    final url = '${AppUrls.salaryMonthsApi}/${appController.loginModel.value.user?.id}';
    println(url);
    final response = await AppApiHandler.getData(url: url,header: headers,);


    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      allSalaries = Salaries.fromJson(json);
      loading.value = false;
      println(json);

    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getAllSalaries();
  }
}