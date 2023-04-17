import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';

import '../../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../../helpers/constants/app_colors.dart';
import 'chain_item_widget.dart';

class ConfirmationWidget extends StatelessWidget {

  ConfirmationWidget({Key? key}) : super(key: key);
  final heightBetweenWidgets = 10.0;
  final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.borderTextFieldColor,width: 0.5)
      ),
      child: Column(
        children: controller.order.confirmation!.map((e) => ChainItemWidget(
          hieghtBetweenWidgets: heightBetweenWidgets,
          name: e.responsibleEmployee?.fullName ?? '',
          job: '12007 - مطور وجهات',
          image: 'assets/images/profile/1.png',
          date:(e.createdAt ?? '').dateFromTZone ,
          time: (e.createdAt ?? '').timeFromTZone,
        ),).toList(),
      ),
    );
  }
}
