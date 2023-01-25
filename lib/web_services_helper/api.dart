import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';


class AppApiHandler {

  static  Future<http.Response> getData(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? body}) async {

    // bool result = await InternetConnectionChecker().hasConnection;
    // if(result == true) {
    //   return Future.error('YAY! Free cute dog pics!');
    // } else {
    //   return Future.error('No internet :( Reason:');
    //   // print(InternetConnectionChecker().);
    // }
    bool result = await InternetConnectionChecker().hasConnection;
    if(!result) {
      throw NoInternetException();
    }
    var uri = Uri.parse(url);
    final response = await http.get(uri, headers: header);


    return response;
  }

  static Future<http.Response> sendData(
      {required String url,
      required dynamic body,
      Map<String, String>? header}) async {
    var uri = Uri.parse(url);

    bool result = await InternetConnectionChecker().hasConnection;
    if(!result) {
      throw NoInternetException();
    }
    final response = await http.post(uri, body: body, headers: header);

    return response;
  }

}
