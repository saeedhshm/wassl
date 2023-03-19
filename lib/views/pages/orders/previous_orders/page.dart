import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/models/orders/holiday.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/order_details/order_details.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../pages/ask_permission.dart';
import '../pages/correcting_fingerprint.dart';
import '../pages/custody_request.dart';
import '../pages/extra_work.dart';
import '../pages/finance_spended_request.dart';
import '../pages/holday_request.dart';
import '../pages/letter_request.dart';
import '../pages/loan_order.dart';
import '../pages/visa_request.dart';

class PreviousRequestsPage extends StatefulWidget {


   PreviousRequestsPage({Key? key}) : super(key: key){
     // retrieveAllOrders();
   }

  @override
  State<PreviousRequestsPage> createState() => _PreviousRequestsPageState();
}

class _PreviousRequestsPageState extends State<PreviousRequestsPage> {

  final PreviousRequestsController controller = Get.put(PreviousRequestsController());


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

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Column(
        children: [
          MainAppbarWidget(
            'previous_requests'.tr,

          ),
          Expanded(child:controller.appController.loading.value ? const SendingLoadingWidget() : controller.previousRequests.value.orders.isEmpty ? Center(
            child: Text('no_previous_requests'.tr,style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.darkGreyTextColor
            ),),
          ):  OrdersListWidget()),
          const SizedBox(height: 100,)
        ],
      )),
    );
  }
}

class OrdersListWidget extends StatelessWidget {
   OrdersListWidget({
    Key? key,
  }) : super(key: key);
   final PreviousRequestsController controller = Get.find<PreviousRequestsController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
        child: ListView.separated(
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
        child: PreviousRequestsItemWidget(order: order),
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

