import 'package:flutter/material.dart';
import 'package:wassl/features/notifications/domain/entities/notification.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../views/reusable_widgets/icons/calendar_icon.dart';
import '../../../../views/reusable_widgets/load_image.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationEntity entity;
  const NotificationItemWidget({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 85,
                height: 85,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ImageController(entity.image).loadImage()),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity.body,
                      style: const TextStyle(
                          color: AppColors.darkGreyTextColor, fontSize: 17),
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 25,
                          height: 25,
                          child: PrefCalendarIcon(),
                        ),
                        Text(
                          entity.date,
                          style: const TextStyle(
                              color: AppColors.darkGreyTextColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }
}
