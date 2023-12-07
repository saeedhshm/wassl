import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/constants/page_status.dart';
import '../../domain/entities/notification.dart';
import '../manager/notifications_controller.dart';
import '../widgets/app_bar.dart';
import '../widgets/item_widget.dart';
import '../widgets/tabs_widget.dart';

class NotificationsPage extends StatelessWidget {
  final NotificationsController controller;
  const NotificationsPage({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Column(
            children: [
              const AppBarWidget(),
              TopTabsWidget(
                controller: controller,
              ),
              Expanded(child: Obx(() {
                if (controller.pageStatus.value is LoadingPageStatus) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.pageStatus.value is SuccessPageStatus) {
                  final List<NotificationEntity> notifications =
                      (controller.pageStatus.value as SuccessPageStatus).data;
                  return SafeArea(
                    child: ListView.separated(
                        padding: const EdgeInsets.only(top: 16),
                        itemBuilder: (context, index) {
                          return NotificationItemWidget(
                            entity: notifications[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: notifications.length),
                    bottom: true,
                    top: false,
                  );
                } else if (controller.pageStatus.value is ErrorPageStatus) {
                  return Center(
                    child: Text((controller.pageStatus.value as ErrorPageStatus)
                        .message),
                  );
                }
                return const SizedBox();
              })),
            ],
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }
}
