import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/tab.dart';

import '../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../helpers/constants/app_colors.dart';

class TabsWidget extends StatelessWidget {
   TabsWidget({Key? key}) : super(key: key);
  final PreviousRequestsController controller = Get.put(PreviousRequestsController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: InkWell(
            onTap: (){
              controller.myOrdersSelected.value = true;
            },child: TabWidget(title: 'my_orders'.tr,tabSelected: controller.myOrdersSelected.value,))),
        Expanded(child: InkWell(
            onTap: (){
              controller.myOrdersSelected.value = false;
            },child: TabWidget(title: 'team_orders'.tr,tabSelected: !controller.myOrdersSelected.value,))),
      ],
    );
  }
}


