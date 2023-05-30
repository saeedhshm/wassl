import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/svg_widget.dart';

class Procedures extends StatelessWidget {
  Procedures({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text(
                  'my_procedures'.tr,
                  style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                const Spacer(),
                Text(
                  'more'.tr,
                  style: const TextStyle(
                      color: AppColors.lightGreyTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [

              Expanded(
                child: ItemWidget(
                  icon:  Image.asset('assets/images/edit.png'),
                  title: 'my_orders'.tr,
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: ItemWidget(
                  icon:  SvgWidget('assets/images/money_on_hand.svg'),
                  title: 'salaries'.tr,
                ),
              ),
              const SizedBox(width: 5,),
              Expanded(
                child: ItemWidget(
                  icon:  SvgWidget('assets/images/letter.svg'),
                  title: 'papers'.tr,
                ),
              ),


            ],
          )
        ],
      ),
    ),
      ],
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  const ItemWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                 icon,
            ),
            decoration: BoxDecoration(
                color: AppColors.mainBackgroundColor,
                borderRadius: BorderRadius.circular(15)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
                color: AppColors.darkGreyTextColor),
          )
        ],
      ),
    );
  }
}
