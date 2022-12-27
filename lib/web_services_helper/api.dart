import 'package:http/http.dart' as http;


class AppApiHandler {
  static void getData(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? body,
      required callback}) async {


    var uri = Uri.parse(url);
    final response = await http.get(uri, headers: header);


    callback(response);
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
