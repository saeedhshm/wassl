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
          SingleChildScrollView(
            child: Row(
              children: [
                ItemWidget(),

                ItemWidget(),

                ItemWidget(),

              ],
            ),
            scrollDirection: Axis.horizontal,
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
    return Row(
      children: [
        Container(
          width: Get.width * 0.5,
          margin: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: const Offset(0,1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/prosedures/cal.png',width: 20,),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Text('25 مارس 2023',style: TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 9
                    ),),
                    SizedBox(width: 5,),
                    Image.asset('assets/images/back_arrow.png',color: AppColors.darkGreyTextColor,width: 20,),
                    const SizedBox(width: 5,),
                    const Text('28 مارس 2023',style: TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 9
                    ),),
                  ],
                ),
                const SizedBox(height: 5,),
                Text('chiefs_meeting'.tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13
                ),),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text('8 ${'am'.tr}',style: const TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 9
                    ),),
                    const SizedBox(width: 5,),
                    const Text(':',style: TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 9
                    ),),
                    const SizedBox(width: 5,),
                    Text('10 ${'am'.tr}',style: const TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 9
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}
