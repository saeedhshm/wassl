import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/finance_info/salaries.dart';
import 'package:wassl/views/pages/orders/previous_orders/page.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../documents/page.dart';

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
                // Text(
                //   'more'.tr,
                //   style: const TextStyle(
                //       color: AppColors.lightGreyTextColor,
                //       fontSize: 14,
                //       fontWeight: FontWeight.normal),
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [

              Expanded(
                child: InkWell(
                  onTap: (){
                    Get.to(PreviousRequestsPage(fromHomePage: true,));
                  },
                  child: ItemWidget(
                    icon: 'assets/images/prosedures/orders.png',
                    title: 'my_orders'.tr,
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    Get.to(()=>AllSalariesPage());
                  },
                  child: ItemWidget(
                    icon:  'assets/images/prosedures/salaries.png',
                    title: 'salaries'.tr,
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: InkWell(
                  onTap: (){
                    Get.to(DocsPage());
                  },
                  child: ItemWidget(
                    icon:  'assets/images/prosedures/docs.png',
                    title: 'papers'.tr,
                  ),
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
  final String icon;
  final String title;
  const ItemWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width / 4.5,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0,1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Image.asset(icon,width: 20,),
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
