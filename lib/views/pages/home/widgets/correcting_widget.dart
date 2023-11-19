import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/home/widgets/abcents.dart';
import 'package:wassl/views/pages/home/widgets/procesures.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import 'ads_widget.dart';
import 'next_events.dart';

class CorrectingWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   CorrectingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const SizedBox(height: 90,),

          Procedures(),
          AbsentsWidget(),
          NextEvents(),
          AdsWidget(),
          const SizedBox(height: 90,)
        ],
      ),
      decoration: const BoxDecoration(
          color: AppColors.mainBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0)
          )
      ),
    );
  }
}


