import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../../models/orders/holiday.dart';

class OrderTypeWidget extends StatelessWidget {

   OrderTypeWidget({super.key});
  final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 25,
              child: Image.asset('assets/images/order_details/Untitled.png'),
            ),
            const SizedBox(width: 16,),
            Text('order_type'.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
            ),),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainGreenColor,width: 0.5),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(controller.order.orderName.tr,style: const TextStyle(
                    color: AppColors.mainGreenColor,
                    fontSize: 12
                ),),
              ),
            ),
            SizedBox(width: controller.order.type?.name != null ? 16 : 0,),
            (controller.order is HolidaysData) ?   Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(controller.order.type?.name ?? '' ,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 12
                ),),
              ),
            )
                : controller.order.type?.name != null ?  Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(controller.order.type?.name ?? '' ,style: const TextStyle(
                    color: AppColors.darkGreyTextColor,
                    fontSize: 12
                ),),
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
