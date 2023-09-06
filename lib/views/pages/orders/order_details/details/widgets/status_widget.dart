import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../consts_widgets/gradiants.dart';
import '../../../../../reusable_widgets/icons/status_icon.dart';

class StatusWidget extends StatelessWidget {

  final Order order;
  const StatusWidget(this.order,{super.key});

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
              child:StatusOnHandIcon(),
            ),
            const SizedBox(width: 16,),
            Text('status'.tr,style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontWeight: FontWeight.bold
            ),),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: AppColors.mainGreenColor,width: 0.5),
                  borderRadius: BorderRadius.circular(50),
                  gradient:order.statusID == 1 ? grayGradiantAwait : order.statusID == 4 ? redGradiantRejected : order.statusID == 3 ? redGradiantCancel : greenGradiantAppBarSecond
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical:'lang_code'.tr == 'ar' ? 2 : 6),
                child: Text((order.status?.statusAr ?? '').tr,style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
