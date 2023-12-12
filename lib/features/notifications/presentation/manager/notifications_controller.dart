import 'package:get/get.dart';
import 'package:wassl/features/notifications/domain/use_cases/get_notifications.dart';

import '../../../../helpers/constants/page_status.dart';
import '../../domain/entities/notification.dart';

class NotificationsController extends GetxController {
  final GetNotificationsUseCase getNotificationsUseCase;
  NotificationsController({required this.getNotificationsUseCase});

  var isWorkNotifs = true.obs;

  Rx<IPageStatus> pageStatus = Rx(InitialPageStatue());

  getAllNotifications() async {
    pageStatus.value = LoadingPageStatus();
    final eitherResult = await getNotificationsUseCase();
    eitherResult.fold((l) {
      pageStatus.value = ErrorPageStatus('no_data_available');
    }, (List<NotificationEntity> r) {
      pageStatus.value = SuccessPageStatus<List<NotificationEntity>>(r);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
