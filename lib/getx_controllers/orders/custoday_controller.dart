import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../models/orders/order_type.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class CustodyRequestController extends GetxController{

  final AppController appController = Get.find();
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  String? reason;
  String? filePath;
  var loadingTypes = false.obs;
  var loading = false.obs;


  Future addNewPermission()async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'permission_type_exception');
    }

    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'reason': '$reason'
    };
    println(body.runtimeType);


    println(body);
    // println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addCustody, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }

  }

  getTypes() async {

    loadingTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getCustodyTypes,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      orderTypes.value = OrderTypesRetriever.fromJson(json);
    }
    loadingTypes.value = false;
    println(response.statusCode);
    println(response.body);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTypes();
  }
}