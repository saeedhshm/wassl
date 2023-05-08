import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../helpers/constants/app_colors.dart';
import '../../../../../helpers/constants/print_ln.dart';
import '../../../../../helpers/exceptions/no_internet.dart';
import 'order.dart';



class PreviousOrdersWidget extends StatelessWidget {
  PreviousOrdersWidget({
    Key? key,
  }) : super(key: key);
  final PreviousRequestsController controller = Get.find<PreviousRequestsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBackgroundColor,
      child: RefreshIndicator(onRefresh: controller.retrieveAllOrders,
      child: ListView.separated(
        padding:  const EdgeInsets.only(left: 16,right: 16,bottom: 10,top: 16),
        itemCount: controller.previousRequests.value.orders.length,
        itemBuilder: (_,index){
          return  OrderWidget(controller.previousRequests.value.orders[index]);
        }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 0,);
      },
      ),

      ),
    );
  }

}