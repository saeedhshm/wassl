import 'dart:convert';

import '../models/holidays/vacations.dart';
import '../web_services_helper/api.dart';

class VacationsController {

  Future<Vacations?> getHolidaysTypes(String url,Map<String, String> header) async {


    var response = await AppApiHandler.getData(url: url,header:header);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      return Vacations.fromJson(json);
    }

    return null;
  }

}