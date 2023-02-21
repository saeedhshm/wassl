import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/models/orders/order_type.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';
import 'order_types_controller.dart';

class AskPermissionController extends GetxController{

  var loadingTypes = false.obs;
  final AppController appController = Get.find();
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;
  String? reason;
  String? filePath;
  var loading = false.obs;
  DateTime? permissionDate;
  int? reasonType;



  Future addNewPermission()async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'permission_type_exception');
    }
    if(permissionDate == null){
      throw CustomException(errorMessage: 'inter_date_exception');
    }
    if(reasonType == null){
      throw CustomException(errorMessage: 'reasonType_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedType?.id}',
      'date': '${permissionDate?.year}-${permissionDate?.month}-${permissionDate?.day}',
      'reason_type': '$reasonType',
      'reason': '$reason'
    };
    println(body.runtimeType);


    println(body);
    // println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.sendDataWithFile(url: AppUrls.addPermission, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }

  }


  getPermissionsTypes() async {

    loadingTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getPermissionsTypes,header: appController.appHeader);

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
    getPermissionsTypes();
  }


}