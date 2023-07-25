import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../views/pages/orders/previous_orders/page.dart';
import '../app_controller.dart';

class PreviousRequestsController extends GetxController{

  var previousRequests = AllOrders().obs;
  var previousTeamRequests = AllOrders().obs;

  List menuItems = [
    ListItem('all_orders', 0,true),
    ListItem('await_status', 1,false),
    ListItem('approved', 2,false),
    ListItem('disapproved', 3,false),
    ListItem('pending', 4,false),
  ];

  var _groupValue = ListItem('all_orders', 0,false).obs;
  var _groupValueOfTeamOrders = ListItem('all_orders', 0,false).obs;

  final AppController appController = Get.find();

  var myOrdersSelected = true.obs;

  Future getAllOrders() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    var url = AppUrls.getAllOrders;
    if(_groupValue.value.status != 0){
      url = '${url}?status=${_groupValue.value.status}';
    }
    println(url);
    // return;
    appController.loading.value = true;
    var response = await AppApiHandler.getData(url: url,header: headers);
    appController.loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
      var json = jsonDecode(response.body);
      previousRequests.value = AllOrders.fromJson(json);

  }

  Future getTeamOrders() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };

    var url = AppUrls.getTeamOrders;
    if(_groupValueOfTeamOrders.value.status != 0){
      url = '${url}?status=${_groupValueOfTeamOrders.value.status}';
    }
    print(url);
    appController.loading.value = true;
    var response = await AppApiHandler.getData(url: url,header: headers);
    appController.loading.value = false;

    if(response.statusCode != 200){
      throw NoDataAvailableException();
    }
    var json = jsonDecode(response.body);
    previousTeamRequests.value = AllOrders.fromJson(json);

  }

  Future retrieveAllOrders() async{
    Future.delayed(Duration.zero,()async{
      try{
        await getAllOrders();
        await getTeamOrders();
      }on NoDataAvailableException catch (e){

        println(e);

      }finally{
        appController.loading.value = false;
      }
    });
  }

  ListItem get groupValue {
    return myOrdersSelected.value ? _groupValue.value : _groupValueOfTeamOrders.value;
  }

  void set groupValue(ListItem value){
    if(myOrdersSelected.value) {
      _groupValue.value = value;
      getAllOrders();
    } else {
      _groupValueOfTeamOrders.value = value;
      getTeamOrders();
    }
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _groupValue.value = menuItems[0];
    _groupValueOfTeamOrders.value = menuItems[0];
  }
}