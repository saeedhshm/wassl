import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../../getx_controllers/attendance/member_attendance_controller.dart';
import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class AbsentsWidget extends StatelessWidget {

   AbsentsWidget({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();
   final controller = Get.find<MembersAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(()=>controller.loading.value ? const Center(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: SendingLoadingWidget(),
        ),
      ) : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text(
                  'absents_from_work'.tr,
                  style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          Obx(() =>controller.teamAbsence.isNotEmpty ? Column(
            children: [
              for(int i=0;i<controller.teamAbsence.length;i++)
                Column(
                  children: [
                    ItemWidget(
                      name: controller.teamAbsence[i].employee?.fullName ?? '',
                      startDate: '25 مارس 2023',
                      endDate: '28 مارس 2023',
                      attendanceStatus: controller.teamAbsence[i].attendance?.attendanceStatus ?? '',
                    ),

                  ],
                ),



            ],
          ):Text('no_absence_today'.tr, style: const TextStyle(
              color: AppColors.darkGreyTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w500)))
        ],
      )),
    );
  }
}

class ItemWidget extends StatelessWidget {

  final String name;
  final String startDate;
  final String endDate;
  final String attendanceStatus;
  const ItemWidget({
    Key? key,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.attendanceStatus
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: Offset(0,1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0,0), // changes position of shadow
                  ),
                ],
              ),
                child: Image.asset('assets/images/profile/1.png',width: 35,)),
            SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 13,
                ),),
                // Row(
                //   children: [
                //     Text(startDate,style: TextStyle(
                //       color: AppColors.lightGreyTextColor,
                //       fontSize: 12
                //     ),),
                //     SizedBox(width: 5,),
                //     Image.asset('assets/images/back_arrow.png',color: AppColors.darkGreyTextColor,width: 20,),
                //     SizedBox(width: 5,),
                //     Text(endDate,style: TextStyle(
                //         color: AppColors.lightGreyTextColor,
                //         fontSize: 12
                //     ),),
                //   ],
                // ),

              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(attendanceStatus.tr,style: TextStyle(
                color: AppColors.lightGreyTextColor,
                fontSize: 10,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
