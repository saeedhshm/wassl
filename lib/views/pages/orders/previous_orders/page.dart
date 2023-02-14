import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../reusable_widgets/main_appbar.dart';

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
       }catch (e){
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
          Expanded(child:controller.appController.loading.value ? const SendingLoadingWidget() : controller.previousRequests.value.isEmpty ? Center(
            child: Text('no_previous_requests'.tr,style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.darkGreyTextColor
            ),),
          ):  OrdersListWidget()),
          SizedBox(height: 100,)
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          itemCount: controller.previousRequests.value.orders.length,
          itemBuilder: (_,index){
            return  OrderWidget(controller.previousRequests.value.orders[index]);
          }, separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20,);
        },
        ),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  
  final Order order;
  const OrderWidget(this.order,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreviousRequestsItemWidget(order: order) ;
  }
}

