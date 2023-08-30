import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';

import '../../../../../../../helpers/constants/app_colors.dart';
import '../../../../../../../models/orders/letter.dart';
import '../../../../../../../models/orders/loan_order.dart';
import '../../../../../../consts_widgets/gradiants.dart';
import '../../../../../../reusable_widgets/gradiant_text.dart';

class OrderTypeName extends StatelessWidget {

   const OrderTypeName(this.order,{Key? key}) : super(key: key);

   final Order order;

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.orderName.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
            order.orderName == 'LetterDate' ?  Text('directed_to'.tr + ' : ' +((order as LetterDate).directedToAr ?? ''),style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 15
            ),) : const SizedBox(),
            order.orderName == 'LoansData' ?  Text('installment_method'.tr + ' : ' +((order as LoansData).monthlyInstallment ?? ''),style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 15
            ),) : const SizedBox(),

            // Spacer(),

          ],
        )),
        GradientText(order.orderStatus.tr,style: TextStyle(  ),
            gradient:order.statusID == 1 ? grayGradiantAwait : order.statusID == 4 ? redGradiantRejected : order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
        )
      ],
    );
  }
}
