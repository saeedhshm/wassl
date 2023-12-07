import '../../domain/entities/notification.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required super.id,
      required super.title,
      required super.body,
      required super.date,
      required super.image,
      required super.doesRead});
}
