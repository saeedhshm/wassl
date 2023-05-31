import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/home/home_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/home/widgets/app_bar_widget.dart';
import 'package:wassl/views/pages/home/widgets/attendance_widget.dart';
import 'package:wassl/views/pages/home/widgets/correcting_widget.dart';
import 'package:wassl/views/pages/home/widgets/shift_info_widget.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

import '../../reusable_widgets/circular_widget.dart';
import '../../reusable_widgets/svg_widget.dart';

class HomePage extends StatelessWidget {

   HomePage({Key? key}) : super(key: key);

   final HomeController controller = Get.put(HomeController());

  // String name = 'محمد حسين';

  @override
  Widget build(BuildContext context) {

    // Expanded(
    //   child: Stack(
    //     children: [
    //       CorrectingWidget(),
    //       AttendanceWidget(),
    //     ],
    //   ),
    // )

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: AppColors.mainBackgroundColor,
            margin: EdgeInsets.only(top: Get.height * 0.6),
          ),
          Column(
            children: [
              HomeBarWidget(),
             Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   children: [
                     const SizedBox(height: 20,),
                     ShiftInfoWidget(),
                     const SizedBox(height: 20,),
                     Stack(
                       children: [
                         CorrectingWidget(),
                         AttendanceWidget(),
                       ],
                     )
                   ],
                 ),
               ),
             )

            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: greenGradiantAppBar,
      ),
    );
  }
}
