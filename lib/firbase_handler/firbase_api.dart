import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:get/get.dart';

class FirebaseApi{

  static const notifIcon = '@drawable/ic_stat_wasl_ic';

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async{

    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    final AppController appController = Get.find();
    appController.fCMToken = fCMToken;

    initPushNotifications();
    initLocalNotifications();
  }





  Future initPushNotifications() async{

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if(notification == null) return;
      _localNotifications.show(notification.hashCode, 
          notification.title, 
          notification.body, 
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: notifIcon
            )
          ),
        payload: jsonEncode(message.toMap())
      );
      
      
    });
  }

  Future initLocalNotifications() async{
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings(notifIcon);
    const settings = InitializationSettings(android: android,iOS: iOS);

    await _localNotifications.initialize(settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:  onDidReceiveNotificationResponse,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  final AndroidNotificationChannel _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:'This channel is used for important notifications.', //
      importance: Importance.defaultImportance,
      playSound: true);


  final _localNotifications = FlutterLocalNotificationsPlugin();
}

void handleMessage(RemoteMessage? message){
  if(message == null) return;

}

Future<void> handleBackgroundMessage(RemoteMessage message) async{

}

onDidReceiveNotificationResponse(payload){
final message = RemoteMessage.fromMap(jsonDecode(payload.payload ?? ''));
handleMessage(message);
}