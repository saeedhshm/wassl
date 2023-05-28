import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/svg_widget.dart';
import 'holidays_widget.dart';

class CorrectingWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   CorrectingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: double.infinity,
      height: double.maxFinite,
      child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const SizedBox(height: 40,),
            HolidaysWidget()
          ],
        ),
      ),
      decoration: const BoxDecoration(
          color: AppColors.mainBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)
          )
      ),
    );
  }
}


