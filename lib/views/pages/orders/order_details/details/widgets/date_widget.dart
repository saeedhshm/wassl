import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../reusable_widgets/icons/calendar_icon.dart';

class DateWidget extends StatelessWidget {

  final Order order;
  const DateWidget(this.order,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const SizedBox(
              width: 25,
              height: 25,
              child:PrefCalendarIcon(),
            ),
            const SizedBox(width: 16,),
            Text('date'.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
            ),),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                borderRadius: BorderRadius.circular(50),
                // gradient:controller.order.statusID == 1 ? grayGradiantAwait : controller.order.statusID == 4 ? redGradiantRejected : controller.order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
              ),
              child: Text((order.orderDate).tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 15
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
