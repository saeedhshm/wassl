import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/svg_widget.dart';

class CorrectingWidget extends StatelessWidget {

  final HomeController controller = Get.find();

   CorrectingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      width: double.infinity,
      height: double.maxFinite,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: controller.appController.deployingForApple ? const SizedBox() : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20
                      ),
                      child: Row(
                        children: [
                          Text('requests'.tr,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                          const Spacer(),
                          Text('more'.tr,style: const TextStyle(
                              color: AppColors.darkGreyTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgWidget('assets/images/finger_print.svg'),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.mainBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('correct'.tr,
                              style: const TextStyle(
                                  color: AppColors.darkGreyTextColor
                              ),)
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgWidget('assets/images/holidays.svg'),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.mainBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('holidays'.tr,
                              style: const TextStyle(
                                  color: AppColors.darkGreyTextColor
                              ),)
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgWidget('assets/images/finger_print.svg'),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColors.mainBackgroundColor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('correct'.tr,
                              style: const TextStyle(
                                  color: AppColors.darkGreyTextColor
                              ),)
                          ],
                        ),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
          ),
        ],
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
