import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class OrderDetailsController extends GetxController{

  var orderDetailsTapSelected = true.obs;

  final AppController appController = Get.find();

  final Order order;
  OrderDetailsController(this.order);

  Future setTeamOrderStatusRequest(String orderStatus) async {

    var body = {
      'order_type':order.confirmation?.first.orderType ?? '',
      'status':orderStatus,
      'order_id':'${order.orderID}'
    };

    appController.loading.value = true;
    var headers = {

      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };
    println(body);
    println(AppUrls.setTeamOrderSatus);
    final response = await AppApiHandler.postData(url: AppUrls.setTeamOrderSatus, body: body,header: headers);
    appController.loading.value = false;
    // order.status?.id = 1;
    if(response.statusCode == 200){
      final message = orderStatus == '2' ? 'order_approved_success'.tr : 'order_disapproved_success'.tr;
      SnackBars.showConfirmedSnackBar('success'.tr, message);
      SnackBars.back();
      Get.delete<OrderDetailsController>();
    }else{
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }
    println(response.body);
    println(response.statusCode);
  }

  bool get isTeamOrder{
    // return true;
    return (appController.loginModel.value.user?.id ?? 0) == (order.activeResponsibleId ?? 0) ;
  }

  List<Confirmation> get confirmation{
    List<Confirmation> confirmations = [];
    if(order.confirmation != null) {
      for (Confirmation c in order.confirmation!) {
        confirmations.add(c);
        if(c.status == 3){
          break;
        }
      }
    }

    return confirmations;
  }


}