import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../models/orders/AllOrders.dart';
import '../../order_details/order_details.dart';
import 'order_item/order_item_widget.dart';

class OrderWidget extends StatelessWidget {


  final Order order;
  const OrderWidget(this.order,{Key? key}) : super(key: key);

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


}