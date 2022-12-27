import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController{

  var loading = false.obs;

  var loaginSuccessed = false.obs;
  
  Future<bool> login({required String email,required String password}){

    println('=== function login called');
    println('==== url : ${AppUrls.login}');
    AppApiHandler.sendData(url: AppUrls.login, body: {
      'email':email,
      'password':password
    }, callback: (response){
      println('===== response called');
      int statusCode = response.statusCode;
      if(statusCode == 200){
        return true;
      }else{
        return false;
      }
      // println(statusCode);
      // println(response.body);
    });
    return false;
  }
}