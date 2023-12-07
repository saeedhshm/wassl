import 'package:wassl/features/notifications/domain/repositories/repository.dart';

class ReadNotificationUseCase {
  final NotificationsRepository repository;

  ReadNotificationUseCase({required this.repository});

  Future<void> call() async {
    await repository.readNotification();
  }
}
