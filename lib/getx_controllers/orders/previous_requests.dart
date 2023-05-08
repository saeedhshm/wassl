import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../app_controller.dart';

class PreviousRequestsController extends GetxController{

  var previousRequests = AllOrders().obs;
  final AppController appController = Get.find();

  var myOrdersSelected = true.obs;

  Future getAllOrders() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    appController.loading.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getAllOrders,header: headers);
    // appController.loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
      var json = jsonDecode(response.body);
      previousRequests.value = AllOrders.fromJson(json);

  }

  Future retrieveAllOrders() async{
    Future.delayed(Duration.zero,()async{
      try{
        await getAllOrders();
      }on NoDataAvailableException catch (e){

        println(e);

      }finally{
        appController.loading.value = false;
      }
    });
  }
}