import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../views/consts_widgets/gradiants.dart';
import '../manager/notifications_controller.dart';

class TopTabsWidget extends StatelessWidget {
  final NotificationsController controller;
  const TopTabsWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Obx(() => Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.isWorkNotifs.value = true;
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: Text(
                              'work'.tr,
                              style: TextStyle(
                                  color: !controller.isWorkNotifs.value
                                      ? Colors.white
                                      : AppColors.darkGreyTextColor),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: controller.isWorkNotifs.value
                                  ? Colors.white
                                  : Colors.transparent),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.isWorkNotifs.value = false;
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 20),
                            child: Text(
                              'occasions'.tr,
                              style: TextStyle(
                                  color: controller.isWorkNotifs.value
                                      ? Colors.white
                                      : AppColors.darkGreyTextColor),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: !controller.isWorkNotifs.value
                                  ? Colors.white
                                  : Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: greenGradiantAppBar,
                    borderRadius: BorderRadius.circular(8)),
              )),
          const Spacer(),
          const Icon(
            Icons.filter_alt_outlined,
            size: 35,
            color: AppColors.darkGreyTextColor,
          )
        ],
      ),
    );
  }
}
