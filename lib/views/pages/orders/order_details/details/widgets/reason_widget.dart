import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../reusable_widgets/icons/chat_icon.dart';

class ReasonWidget extends StatelessWidget {
  final Order order;
  const ReasonWidget(this.order,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 25,
              child: ChatConversationIcon(),
            ),
            const SizedBox(width: 16,),
            Text('reason'.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
            ),),
            const Text(' : '),
            Expanded(

              child: Text((order.reason ).tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 16
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
