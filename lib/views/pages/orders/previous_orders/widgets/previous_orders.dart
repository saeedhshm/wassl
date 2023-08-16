import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../helpers/constants/app_colors.dart';
import '../../../../consts_widgets/loading_widgets.dart';
import 'order.dart';



class PreviousOrdersWidget extends StatelessWidget {
  PreviousOrdersWidget({
    Key? key,
  }) : super(key: key);
  final PreviousRequestsController controller = Get.find<PreviousRequestsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.appController.loading.value ? const SendingLoadingWidget() : controller.myOrders.isEmpty ? Center(
      child: Text('no_previous_requests'.tr,style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.darkGreyTextColor
      ),),
    ): Container(
      color: AppColors.mainBackgroundColor,
      child: RefreshIndicator(onRefresh: controller.retrieveAllOrders,
        child: ListView.separated(
          padding:  const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 16),
          itemCount: controller.myOrders.length,
          itemBuilder: (_,index){

            return  OrderWidget(controller.myOrders[index]);
          }, separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 0,);
        },
        ),

      ),
    ));
  }

}