import 'package:dartz/dartz.dart';
import 'package:wassl/helpers/errors/failures.dart';

import '../entities/notification.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getAllNotifications();
  Future<void> readNotification();
}
