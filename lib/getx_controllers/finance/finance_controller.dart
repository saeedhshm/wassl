import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../models/finance/finance.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class FinanceInfoController extends GetxController {

  String? month; String? year;

  FinanceInfoController({this.month,this.year});

  final AppController appController = Get.find();
  var loading = false.obs;
  var finance = Finance();

  Future<void> _getTeamAttendance() async {
    var headers = {
      'Authorization':
          'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    loading.value = true;

    var url =
        '${AppUrls.salaryDetailsApi}/${appController.loginModel.value.user?.id}';
    if(month != null && year != null){
      url += '?year=$year&month=$month';
    }
    println(url);
    final response = await AppApiHandler.getData(
      url: url,
      header: headers,
    );

    if (response.statusCode != 200) {
      throw NoDataAvailableException();
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      finance = Finance.fromJson(json);
      loading.value = false;
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
