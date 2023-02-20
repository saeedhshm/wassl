import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/models/orders/letter/letter_types.dart';

import '../../helpers/constants/print_ln.dart';
import '../../helpers/exceptions/custom_exception.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class LetterRequestController extends GetxController{

  var loading = false.obs;
  var loadingLetterTypes = false.obs;
  final AppController appController = Get.find();

  String? reason;
  String? filePath;
  int? type;
  String? directedToAr;
  String? directedToEn;
  LetterType? selectedLetterType;

  var letterTypes = LetterTypes().obs;


  Future addNewLetter()async{

    if(selectedLetterType == null) {
      throw CustomException(errorMessage: 'letter_type_exception');
    }
    if(directedToAr == null || directedToAr == ''){
      throw CustomException(errorMessage: 'directed_to_ar_exception');
    }
    if(directedToEn == null || directedToEn == ''){
      throw CustomException(errorMessage: 'directed_to_en_exception');
    }
    if(reason == null || reason == ''){
      throw CustomException(errorMessage:'reason_exception');
    }

    var body = {
      'type': '${selectedLetterType?.id}',
      'directed_to_en': '$directedToEn',
      'directed_to_ar': '$directedToAr',
      'reason': '$reason'
    };
    println(body);


    println(body);
    println(appController.appHeader);

    loading.value = true;
    var response = await  AppApiHandler.sendDataWithFile(url: AppUrls.addLetter, body: body,header: appController.appHeader,fileName: filePath);
    println(response.statusCode);
    println(await response.stream.bytesToString());
    loading.value = false;
    if(response.statusCode != 200){
      throw CustomException();
    }

  }

  getLetterTypes() async {

    loadingLetterTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getLetterTypes,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      letterTypes.value = LetterTypes.fromJson(json);
    }
    loadingLetterTypes.value = false;
    println(response.statusCode);
    println(response.body);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLetterTypes();
  }

}