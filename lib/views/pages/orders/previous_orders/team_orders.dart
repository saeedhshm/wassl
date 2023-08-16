import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/order.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../consts_widgets/loading_widgets.dart';

class TeamOrderPage extends StatelessWidget {

  final PreviousRequestsController controller = Get.put(PreviousRequestsController());

   TeamOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: Get.width,
      height: Get.height,
      color: AppColors.mainBackgroundColor,
      child: controller.appController.loading.value ? const SendingLoadingWidget() : controller.previousTeamRequests.value.orders.isEmpty ? Center(
        child: Text('No Team Orders Yet'.tr,style: const TextStyle(
            color: AppColors.darkGreyTextColor,
            fontWeight: FontWeight.bold
        ),),
      ): Container(
        color: AppColors.mainBackgroundColor,
        child: RefreshIndicator(onRefresh: controller.retrieveAllOrders,
          child: ListView.separated(
            padding:  const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 16),
            itemCount: controller.previousTeamRequests.value.orders.length,
            itemBuilder: (_,index){
              return OrderWidget(controller.previousTeamRequests.value.orders[index]);
            }, separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 0,);
          },
          ),

        ),
      ),
    ));
  }
}
