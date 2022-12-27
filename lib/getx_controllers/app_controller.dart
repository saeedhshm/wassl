import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/auth/LoginModel.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';
import 'package:http/http.dart' as http;

import '../helpers/constants/sring_constans.dart';

class AppController extends GetxController{

  var loading = false.obs;

  var loaginSuccessed = false.obs;

  var loginModel = LoginModel().obs;
  var rememberMe = false;
  
  Future<bool> login({required String email,required String password}) async {
    println('=-=-=-=->>> rememberMe $rememberMe');
    if(rememberMe){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(appStorageEmail, email);
      await prefs.setString(appStoragePassword, password);
    }
    loading.value = true;
   final response = await AppApiHandler.sendData(url: AppUrls.login, body: {
      'email':email,
      'password':password
    });
    int statusCode = response.statusCode;


    loading.value = false;
      if(statusCode == 200){
        Map<String,dynamic> json = jsonDecode(response.body);
        // println(json);
        loginModel.value.fromJson(json);
        // println('=-=-=-=-=->> ${loginModel.value.user?.email}');
        // println('=-=-=-=-=->> ${loginModel.value.user?.name}');
        // println('=-=-=-=-=->> ${loginModel.value.user?.fatherName}');
        // println('=-=-=-=-=->> ${loginModel.value.user?.probationPeriod}');
        return true;
      }


    return false;
  }


 Future logout() async{
    final prefs = await SharedPreferences.getInstance();
   await prefs.setString(appStorageEmail, 'null');
   await prefs.setString(appStoragePassword, 'null');
    final String email = prefs.getString(appStorageEmail) ?? 'null';
    final String password = prefs.getString(appStoragePassword) ?? 'null';
    println('=-=-=-=->>> retrieveUserAuth email $email');
    println('=-=-=-=->>> retrieveUserAuth password $password');
    loginModel.value = LoginModel();
  }

  Future<Map<String,String>> retrieveUserAuth() async {
    var userCreds = <String,String>{};
    final prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString(appStorageEmail) ?? 'null';
    final String password = prefs.getString(appStoragePassword) ?? 'null';

    userCreds.addAll({'email':email,'password':password});
    return userCreds;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
}