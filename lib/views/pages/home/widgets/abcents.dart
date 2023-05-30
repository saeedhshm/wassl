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
              Text('أحمد محمد',style: TextStyle(
                color: AppColors.darkGreyTextColor,

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
