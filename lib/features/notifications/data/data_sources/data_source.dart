import '../models/model.dart';

abstract class NotificationsDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationsTestDataSource extends NotificationsDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    var notifications = <NotificationModel>[];
    await Future.delayed(const Duration(seconds: 2));

    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    notifications.add(NotificationModel(
        id: 0,
        title: '',
        body: notifInfo,
        date: notifDate,
        image: notifImage,
        doesRead: false));
    return notifications;
  }

  String get notifImage {
    return 'assets/images/placeholders/traffic_logo.png';
  }

  String get notifInfo {
    return 'كان لوريم إيبسوم ولايزال المعيار للنص الشكلي منذ القرن الخامس';
  }

  String get notifDate {
    return '2022 /5/10';
  }
}

class NotificationsRemoteDataSource extends NotificationsDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() {
    throw Exception();
  }
}
