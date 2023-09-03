import 'dart:convert';

import '../getx_controllers/orders/order_types_controller.dart';
import '../web_services_helper/api.dart';

class TypesController{

  Future<OrderTypesRetriever?> getTypes(String url, Map<String,String> header) async {


    var response = await AppApiHandler.getData(url: url,header: header);


    if(response.statusCode == 200){

      var json = jsonDecode(response.body);

      return OrderTypesRetriever.fromJson(json);
    }

    return null;

  }

}