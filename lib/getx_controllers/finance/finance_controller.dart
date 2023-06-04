import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class FinanceInfoController extends GetxController{
  final AppController appController = Get.find();
  var loading = false.obs;

  Future<void> _getTeamAttendance() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };


    loading.value = true;

    final url = '${AppUrls.salaryDetailsApi}/${appController.loginModel.value.user?.id}';
println(url);
    final response = await AppApiHandler.getData(url: url,header: headers,);
    loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    if(response.statusCode == 200){
      var json = jsonDecode(response.body);

println(json);

    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    this._getTeamAttendance();
  }
}