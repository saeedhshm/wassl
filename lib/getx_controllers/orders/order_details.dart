import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';

class OrderDetailsController extends GetxController{

  var orderDetailsTapSelected = true.obs;

  final Order order;
  OrderDetailsController(this.order);
}