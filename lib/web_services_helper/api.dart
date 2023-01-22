import 'package:http/http.dart' as http;


class AppApiHandler {

  static  Future<http.Response> getData(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? body}) async {


    var uri = Uri.parse(url);
    final response = await http.get(uri, headers: header);


    return response;
  }

  static Future<http.Response> sendData(
      {required String url,
      required dynamic body,
      Map<String, String>? header}) async {
    var uri = Uri.parse(url);

    final response = await http.post(uri, body: body, headers: header);

    return response;
  }

}
