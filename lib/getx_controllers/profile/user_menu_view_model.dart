import 'package:get/get.dart';

import '../app_controller.dart';

class UserMenuViewModel extends GetxController{
  final AppController appController = Get.find();

  bool get hideSections{
    return appController.deployingForApple;
}

String get availableVacationsCount{
    return '${(appController.holidaysBalance.value.data?.availableVacationsCount ?? 0).toInt()}';
}

String get fullName{
    return appController.loginModel.value.user?.fullName ?? '';
}

String get jobName{
    return appController.loginModel.value.user?.job?.name ?? '';
}

String get userImage{
    return 'assets/images/profile/1.png';
}
}