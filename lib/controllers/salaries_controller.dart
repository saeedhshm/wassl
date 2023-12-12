import 'dart:convert';

import '../helpers/exceptions/internet_api_exceptions.dart';
import '../models/finance/salaries.dart';
import '../web_services_helper/api.dart';

class SalariesController {
  Future<Salaries?> getAllSalaries(
      String url, Map<String, String> headers) async {
    final response = await AppApiHandler.getData(
      url: url,
      header: headers,
    );

    if (response.statusCode != 200) {
      throw NoDataAvailableException();
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return Salaries.fromJson(json);
    }
    return null;
  }
}
