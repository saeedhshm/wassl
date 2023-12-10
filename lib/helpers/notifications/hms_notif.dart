import 'package:flutter/services.dart';
import 'package:huawei_push/huawei_push.dart';

import '../constants/print_ln.dart';

class HMSService {
  String token = '';

  HMSService();

  Future<String> init() async {
    await Push.setAutoInitEnabled(true);
    turnOnPush();
    await initTokenStream();

    await initMessageStream();
    bool backgroundMessageHandler =
        await Push.registerBackgroundMessageHandler(backgroundMessageCallback);
    Push.onMessageReceivedStream.listen(backgroundMessageCallback);
    Push.onMessageReceivedStream.forEach(backgroundMessageCallback);
    final initialNotification = await Push.getInitialNotification();
    _onNotificationOpenedApp(initialNotification);
    await Future.delayed(const Duration(seconds: 1));
    return token;
  }

  void _onTokenEvent(String event) {
    // Requested tokens can be obtained here

    token = event;
    println('token in hsm $token');
  }

  void _onTokenError(Object error) {
    PlatformException e = error as PlatformException;
    // showResult('TokenErrorEvent', e.message!);
  }

  Future<void> initTokenStream() async {
    // getId();
    getToken();
    // if (!mounted) return;
    Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }

  void getToken() async {
    var aaid = await Push.getAAID();
    Push.getToken(aaid ?? '');
  }

  void getiId() async {
    String? result = await Push.getId();
    println("result id $result");
  }

  static void backgroundMessageCallback(RemoteMessage remoteMessage) async {
    String? data = remoteMessage.data;
    println('remoteMessage.data');
    println(data);

    Push.localNotification({
      HMSLocalNotificationAttr.TITLE: '[Headless] DataMessage Received',
      HMSLocalNotificationAttr.MESSAGE: data
    });
  }

  void _onNotificationOpenedApp(dynamic initialNotification) {
    if (initialNotification != null) {
      println(initialNotification.toString(), 'onNotificationOpenedApp');
    }
  }

  void _onMessageReceived(RemoteMessage remoteMessage) {
    // Called when a data message is received
    String? data = remoteMessage.data;
    println('remoteMessage.data');
    println(remoteMessage.data);
  }

  void _onMessageReceiveError(Object error) {
    // Called when an error occurs while receiving the data message
  }

  Future<void> initMessageStream() async {
    // if (!mounted) return;
    Push.onMessageReceivedStream
        .listen(_onMessageReceived, onError: _onMessageReceiveError);
  }

  void turnOnPush() async {
    String result = await Push.turnOnPush();
    println('Push.turnOnPush(): $result');
    // Push.showToast(result);
  }
}
