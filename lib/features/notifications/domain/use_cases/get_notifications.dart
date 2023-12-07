import 'package:dartz/dartz.dart';
import 'package:wassl/features/notifications/domain/repositories/repository.dart';

import '../../../../helpers/errors/failures.dart';
import '../entities/notification.dart';

class GetNotificationsUseCase {
  final NotificationsRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<NotificationEntity>>> call() async {
    return await repository.getAllNotifications();
  }
}
