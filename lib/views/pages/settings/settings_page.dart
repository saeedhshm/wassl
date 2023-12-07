import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/views/pages/settings/pages/change_lang.dart';
import 'package:wassl/views/pages/settings/pages/change_password.dart';

import '../../../features/notifications/data/data_sources/data_source.dart';
import '../../../features/notifications/data/repositories/repository_impl.dart';
import '../../../features/notifications/domain/use_cases/get_notifications.dart';
import '../../../features/notifications/presentation/manager/notifications_controller.dart';
import '../../../features/notifications/presentation/pages/notif_page.dart';
import '../../consts_widgets/loading_widgets.dart';
import '../../reusable_widgets/dark_text_widget.dart';
import '../../reusable_widgets/list_profile_item_widget.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../auth/login.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              body: Column(
                children: [
                  MainAppbarWidget(
                    'profile'.tr,
                    onBack: () {
                      Get.back();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DarkTextWidget(
                          'settings'.tr,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 8,
                        ),

                        InkWell(
                          onTap: () {
                            Get.to(() => NotificationsPage(
                                controller: Get.put(NotificationsController(
                                    getNotificationsUseCase:
                                        GetNotificationsUseCase(
                                            repository: NotificationRepositoryImpl(
                                                NotificationsTestDataSource())))
                                  ..getAllNotifications())));
                          },
                          child: ListProfileItemWidget(
                            title: "notifs".tr,
                            spaceInBetween: 16,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            iconSize: 35,
                            icon: "assets/images/settingicons/12.png",
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            Get.to(() => const ChangePasswordPage());
                          },
                          child: ListProfileItemWidget(
                            title: "change_password".tr,
                            spaceInBetween: 16,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            iconSize: 35,
                            icon: "assets/images/settingicons/13.png",
                          ),
                        ),
                        // appController.deployingForApple ? const SizedBox() :
                        InkWell(
                          onTap: () {
                            Get.to(() => ChangeLangPage());
                          },
                          child: ListProfileItemWidget(
                            title: "change_lang".tr,
                            spaceInBetween: 16,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            iconSize: 35,
                            icon: "assets/images/settingicons/14.png",
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await appController.logout();
                            Get.to(() => const LoginPage());
                          },
                          child: ListProfileItemWidget(
                            title: "logout".tr,
                            spaceInBetween: 16,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            iconSize: 35,
                            icon: "assets/images/settingicons/11.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            appController.loading.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: SendingLoadingWidget(),
                    ))
                : const SizedBox(),
          ],
        ));
  }
}
