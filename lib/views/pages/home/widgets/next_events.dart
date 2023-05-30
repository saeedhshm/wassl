import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class NextEvents extends StatelessWidget {

  NextEvents({Key? key}) : super(key: key);
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text(
                  'next_events'.tr,
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
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Stack(
              children: [
                Positioned(
                    bottom:0,
                    left: 0,
                    child: Image.asset('assets/images/prosedures/events.png',width: 50,)),
                Column(
                  children: [
                    ItemWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.mainBackgroundColor
                        ),
                      ),
                    ),
                    ItemWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.mainBackgroundColor
                        ),
                      ),
                    ),
                    ItemWidget(),

                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('chiefs_meeting'.tr,style: TextStyle(
            color: AppColors.darkGreyTextColor,
            fontWeight: FontWeight.bold

          ),),
          Row(
            children: [
              Text('25 مارس 2023',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
              SizedBox(width: 5,),
              Image.asset('assets/images/back_arrow.png',color: AppColors.darkGreyTextColor,width: 20,),
              SizedBox(width: 5,),
              Text('28 مارس 2023',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
            ],
          ),
          Row(
            children: [
              Text('8 ${'am'.tr}',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
              SizedBox(width: 5,),
              Text(':',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
              SizedBox(width: 5,),
              Text('10 ${'am'.tr}',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
            ],
          ),
        ],
      ),
    );
  }
}
