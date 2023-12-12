import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/features/home/data/repositories/home_repository.dart';
import 'package:wassl/features/home/presentation/manager/home_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/home/widgets/app_bar_widget.dart';
import 'package:wassl/views/pages/home/widgets/correcting_widget.dart';
import 'package:wassl/views/pages/home/widgets/shift_info_widget.dart';

import '../../../features/home/domain/use_cases/location_use_case.dart';
import '../holidays/holiday_details.dart';
import 'widgets/holidays_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController controller = Get.put(
      HomeController(LocationUseCase(homeRepository: HomeRepositoryImpl())));

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(
                        height: 20,
                      ),
                      ShiftInfoWidget(),
                      Stack(
                        children: [
                          CorrectingWidget(),
                          InkWell(
                              onTap: () {
                                Get.to(() => HolidaysDetails());
                              },
                              child: HolidaysWidget()),
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
