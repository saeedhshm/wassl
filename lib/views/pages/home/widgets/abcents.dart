import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class AbsentsWidget extends StatelessWidget {

   AbsentsWidget({Key? key}) : super(key: key);
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
                    child: Image.asset('assets/images/prosedures/absance.png',width: 50,)),
                Column(
                  children: [
                    const ItemWidget(
                      name: 'أحمد محمد',
                      startDate: '25 مارس 2023',
                      endDate: '28 مارس 2023',
                    ),
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
                    const ItemWidget(
                      name: 'حسني السيد',
                      startDate: '20 ابريل 2023',
                      endDate: '22 ابريل 2023',
                    ),
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
                    const ItemWidget(
                      name: 'فتحي محمد',
                      startDate: '2 مارس 2023',
                      endDate: '5 مارس 2023',
                    ),

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

  final String name;
  final String startDate;
  final String endDate;
  const ItemWidget({
    Key? key,
    required this.name,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: Image.asset('assets/images/profile/1.png',width: 50,)),
          SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: TextStyle(
                color: AppColors.darkGreyTextColor,

              ),),
              Row(
                children: [
                  Text(startDate,style: TextStyle(
                    color: AppColors.lightGreyTextColor,
                    fontSize: 12
                  ),),
                  SizedBox(width: 5,),
                  Image.asset('assets/images/back_arrow.png',color: AppColors.darkGreyTextColor,width: 20,),
                  SizedBox(width: 5,),
                  Text(endDate,style: TextStyle(
                      color: AppColors.lightGreyTextColor,
                      fontSize: 12
                  ),),
                ],
              ),
              Text('annual'.tr,style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),
            ],
          )
        ],
      ),
    );
  }
}
