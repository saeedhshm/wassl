import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/no_internet.dart';
import '../../models/covenant/covenants.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class CovenantsController extends GetxController{

  var myCovenants = Covenants().obs;

  final AppController appController = Get.find();

  Future getAllCovenants() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };

    appController.loading.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.covenantApi,header: headers);
    appController.loading.value = false;

    println(response.body);
    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    var json = jsonDecode(response.body);
    myCovenants.value = Covenants.fromJson(json);

  }
}