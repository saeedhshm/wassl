import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/docs/documents.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class DocsController extends GetxController{

  var myDocs = Documents().obs;

  final AppController appController = Get.find();

  Future getAllDocs() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };

    appController.loading.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.documentsApi,header: headers);
    appController.loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    var json = jsonDecode(response.body);
    myDocs.value = Documents.fromJson(json);

  }
}