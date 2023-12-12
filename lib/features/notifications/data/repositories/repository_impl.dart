import 'package:dartz/dartz.dart';
import 'package:wassl/features/notifications/data/data_sources/data_source.dart';
import 'package:wassl/features/notifications/domain/entities/notification.dart';
import 'package:wassl/features/notifications/domain/repositories/repository.dart';
import 'package:wassl/helpers/errors/failures.dart';

class NotificationRepositoryImpl extends NotificationsRepository {
  final NotificationsDataSource dataSource;

  NotificationRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>>
      getAllNotifications() async {
    try {
      final notifications = await dataSource.getNotifications();
      return Right(notifications);
    } catch (e) {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<void> readNotification() {
    // TODO: implement readNotification
    throw UnimplementedError();
  }
}
