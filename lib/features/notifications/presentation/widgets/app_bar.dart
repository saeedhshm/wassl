import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../views/reusable_widgets/main_appbar.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MainAppbarWidget(
      'notifs'.tr,
      onBack: () {
        // NotifsController.deleteInstance();
        Get.back();
      },
    );
  }
}
