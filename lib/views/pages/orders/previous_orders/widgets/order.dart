import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../../helpers/constants/print_ln.dart';
import '../../../../../helpers/exceptions/no_internet.dart';
import '../../../../../models/orders/AllOrders.dart';
import '../../order_details/order_details.dart';
import 'order_item/order_item_widget.dart';

class OrderWidget extends StatelessWidget {

  final PreviousRequestsController controller = Get.find<PreviousRequestsController>();

  final Order order;
  OrderWidget(this.order,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.put(OrderDetailsController(order));
        Get.to(()=> OrderDetailsPage());
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: OrderItemWidget(order: order),
      ),
    ) ;
  }

  retrieveAllOrders() async{
    Future.delayed(Duration.zero,()async{
      try{
        await controller.getAllOrders();
      }on NoDataAvailableException catch (e){
        println('============ getall orders =========');
        println(e);
        println('============ getall orders =========getall orders =========');
      }finally{
        controller.appController.loading.value = false;
      }
    });
  }
}