import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import 'attendance_widget.dart';

class ShiftInfoWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   ShiftInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Obx(() => Column(
      children: [
        Text(controller.branchName,style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600
        ),),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(controller.currentShiftTitle,style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),),

          ],
        ),
        const SizedBox(height: 10,),
        Text('${controller.currentShiftTimeIn} - ${controller.currentShiftTimeOut}',style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500
        ),),
        const SizedBox(height: 20,),
        AttendanceWidget(),
      ],
    ));
  }
}
