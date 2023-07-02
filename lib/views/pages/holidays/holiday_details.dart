import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/holiday/holiday_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/holidays/widgets/holiday_info_item.dart';
import 'package:wassl/views/pages/holidays/widgets/separator.dart';
import 'package:wassl/views/pages/holidays/widgets/vacation_item.dart';

import '../../../models/holidays/vacations.dart';
import '../../consts_widgets/gradiants.dart';
import '../../reusable_widgets/localized_text.dart';

class HolidaysDetails extends StatelessWidget {

  HolidaysDetails({Key? key}) : super(key: key){
    controller.getHolidaysTypes();
  }
  final HolidayDetailsController controller = Get.put(HolidayDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // app bar
          Container(
            decoration: BoxDecoration(
              gradient: greenGradiantAppBar,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16),
                child: Row(
                  children: [
                    LocalizedText(
                      'anual_vacations'.tr,
                      textStyle: const TextStyle(color: Colors.white, fontSize: 24,fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){

                        Get.back();

                      },
                      child: Container(
                          child: Image.asset(
                            'assets/images/back_arrow.png',
                            width: 50,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Stack(
            children: [
          Container(
          // height: Get.width,
            width: Get.width ,
            height: Get.width / 2.2,
          decoration: BoxDecoration(
          gradient: greenGradiantAppBar,
          ),
          ),
              Obx(()=>SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // vacations info
                    Container(
                      // height: Get.width,
                      decoration: BoxDecoration(
                        gradient: greenGradiantAppBar,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                HolidayInfoItemWidget(
                                  icon: 'assets/images/holidays/1.png',
                                  title: 'available_vacations'.tr,
                                  count: '${controller.vacations.value.data?.availableVacationsCount}',
                                ),
                                HolidayInfoItemWidget(
                                  icon: 'assets/images/holidays/2.png',
                                  title: 'taken_vacations'.tr,
                                  count: '${controller.vacations.value.data?.usedVacationsCount}',
                                ),
                                HolidayInfoItemWidget(
                                  icon: 'assets/images/holidays/3.png',
                                  title: 'base_vacations'.tr,
                                  count: '${controller.vacations.value.data?.openingVacationsCount}',
                                ),
                                SizedBox(width: 16,)
                              ],
                            ),
                          ),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                    //incoming_vacations header
                  Container(
                    width: Get.width ,
                    color: AppColors.mainBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: AppColors.mainBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('incoming_vacations'.tr,style: const TextStyle(
                                color: AppColors.darkGreyTextColor
                            ),),
                          ),
                        ),
                        const SeparatorWidget(),
                        //incoming vacations widget
                        (controller.vacations.value.data?.nextVacations ?? []).isNotEmpty ? VacationItemWidget(vacations: controller.vacations.value.data?.nextVacations ?? [],) :
                        Container(
                          width: double.maxFinite,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: Text('no_incoming_vacations'.tr)),
                          ),
                        ),
                        const SeparatorWidget(),
                        //previous_vacations header
                        Container(
                          color: AppColors.mainBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('previous_vacations'.tr,style: const TextStyle(
                                color: AppColors.darkGreyTextColor
                            ),),
                          ),
                        ),
                        const SeparatorWidget(),
                        //previous_vacations widget
                        (controller.vacations.value.data?.previousVacations ?? []).isNotEmpty ? VacationItemWidget(vacations: controller.vacations.value.data?.previousVacations ?? [],)
                            :Container(
                          width: double.maxFinite,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: Text('no_previous_vacations'.tr)),
                          ),
                        ),
                        const SeparatorWidget(),
                      ],
                    ),
                  )
                  ],
                ),
              ))
            ],
          ))

        ],
      ),
    );
  }
}




