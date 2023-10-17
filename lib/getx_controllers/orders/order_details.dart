import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:wassl/getx_controllers/orders/previous_requests.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

import '../../utils/file_utils.dart';
import '../../web_services_helper/api.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class OrderDetailsController extends GetxController{

  var orderDetailsTapSelected = true.obs;

  final AppController appController = Get.find();

  final Order order;

  OrderDetailsController(this.order);

  Future setTeamOrderStatusRequest(String orderStatus,String comment) async {

    var body = {
      'order_type':order.confirmation?.first.orderType ?? '',
      'status':orderStatus,
      'order_id':'${order.orderID}',
      'hr_comment' : comment
    };


    appController.loading.value = true;

    var headers = {

      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      "x-localization": 'lang_code'.tr,
    };


    final response = await AppApiHandler.postData(url: AppUrls.setTeamOrderSatus, body: body,header: headers);

    if(response.statusCode == 200){
      final message = orderStatus == '2' ? 'order_approved_success'.tr : 'order_disapproved_success'.tr;
      final PreviousRequestsController prevController = Get.find();
      await prevController.getMyOrders();
      await prevController.getTeamOrders();
      Get.back();
      Future.delayed(Duration.zero,(){
        SnackBars.showConfirmedSnackBar('success'.tr, message);
      });
      // SnackBars.back();


      Get.delete<OrderDetailsController>();
      appController.loading.value = false;
    }else{
      Get.back();
      Future.delayed(Duration.zero,(){
        SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
      });

      appController.loading.value = false;
    }
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

  Future<Uint8List> downloadPdfFile(String pdfUrl) async{
    var response = await AppApiHandler.getData(url: pdfUrl,header: appController.appHeader);
    var listOfBytes =  response.bodyBytes;
    var filePath = await FileUtility.writeFileToDirectory(listOfBytes, pdfUrl.split('/').last);


    OpenFile.open(filePath);
   return listOfBytes;
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;

    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}