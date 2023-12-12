import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/home/presentation/manager/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../views/reusable_widgets/circular_widget.dart';

class AttendanceInfoWidget extends StatelessWidget {
  AttendanceInfoWidget({Key? key}) : super(key: key);
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Container(
          child: CircularWidget(
              size: 40,
              borderWidth: 0,
              padding: 0,
              borderColor: Colors.transparent,
              child: Image.asset(
                'assets/images/profile/1.png',
                color: AppColors.iconsColor,
              )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 1,
                spreadRadius: 0,
              )
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.attendanceStatusValue,
                style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              // SizedBox(height: 10,),
              Text(
                controller.currentTime,
                style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: SizedBox(
            width: 35,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Image.asset('assets/images/attend_print_ic.png')),
          ),
        )
      ],
    );
  }
}
