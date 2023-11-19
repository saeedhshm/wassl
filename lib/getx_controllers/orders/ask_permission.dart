
import 'package:get/get.dart';
import 'package:wassl/controllers/types_controllers.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/models/orders/order_type.dart';
import 'package:intl/intl.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../helpers/exceptions/no_internet.dart';
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
  OrderType? reasonType;
  // var correctionTime = ''.obs;
  final _timeIn = ''.obs;
  final _timeOut = ''.obs;

  var errorsList = <String>[].obs;

  Future addNewPermission()async{

    if(selectedType == null) {
      throw CustomException(errorMessage: 'permission_type_exception');
    }
    if(permissionDate == null){
      throw CustomException(errorMessage: 'inter_date_exception');
    }
    if(timeIn.isEmpty){
      throw CustomException(errorMessage: 'time_in_exception');
    }
    if(timeOut.isEmpty){
      throw CustomException(errorMessage: 'time_out_exception');
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
      'reason_type': '${reasonType?.id}',
      'reason': '$reason',
      "time_in": _timeIn.value,
      "time_out": _timeOut.value,
    };


    loading.value = true;
    var response = await  AppApiHandler.postDataWithFile(url: AppUrls.addPermission, body: body,header: appController.appHeader,fileName: filePath);


    loading.value = false;
    if(response.statusCode != 200){
      var responsebody = await response.stream.bytesToString();
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: $responsebody');
      throw CustomException();
    }

  }

  Future updateRequest(String orderId) async{
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
      'reason_type': '${reasonType?.id}',
      'reason': '$reason',
      "time_in": _timeIn.value,
      "time_out": _timeOut.value,
    };


    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updatePermission}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

    var resp = await response.stream.bytesToString();

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${await response.stream.bytesToString()}');
      throw NoDataAvailableException();
    }
  }


  Future cancelRequest(String orderId) async{


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelPermission}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${response.body}');
      throw NoDataAvailableException();
    }
  }


  getPermissionsTypes() async {

    loadingTypes.value = true;

    orderTypes.value = await TypesController().getTypes(AppUrls.getPermissionsTypes, appController.appHeader) ?? OrderTypesRetriever();


    loadingTypes.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPermissionsTypes();
  }

  var reasonTypes = [
    OrderType(id: 1,)..name = 'personal_permission'.tr,
    OrderType(id: 2,)..name = 'illness_permission'.tr,
    OrderType(id: 3,)..name = 'emergency_permission'.tr,
  ];

  String get timeIn{
    var time = '';

    if(_timeIn.value.isNotEmpty){

      time = _timeIn.value.formattedTime() ?? '';
    }

    return time ;
  }

  String get timeOut{
    var time = '';

    if(_timeOut.value.isNotEmpty){
      time = _timeOut.value.formattedTime() ?? '';
    }

    return time ;
  }

   set timeIn(selectedTime){

     if(selectedTime != null){
       DateFormat dateFormatOf24Hours = DateFormat("H:m");
       var timeIn24 = dateFormatOf24Hours.parse('${selectedTime.hour}:${selectedTime.minute}');
       _timeIn.value = timeIn24.toString().split(' ')[1].split('.')[0];

     }
  }

  set timeOut(selectedTime){

    if(selectedTime != null){
      DateFormat dateFormatOf24Hours = DateFormat("H:m");
      var timeIn24 = dateFormatOf24Hours.parse('${selectedTime.hour}:${selectedTime.minute}');
      _timeOut.value = timeIn24.toString().split(' ')[1].split('.')[0];

    }
  }

  set timeInString(String value){
    _timeIn.value = value;
  }

  set timeOutString(String value){
    _timeOut.value = value;
  }

}

