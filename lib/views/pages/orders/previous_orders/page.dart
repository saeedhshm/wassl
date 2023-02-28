import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/models/orders/holiday.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../pages/holday_request.dart';

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
    return InkWell(
      onTap: (){
        if(order.statusID == 1){
          switch(order.orderType){
            case 'AskPermissionsData':
              println('order is AskPermissionsData');
              break;
            case 'CustodyDate':
              println('order is CustodyDate');
              break;
            case 'FinancialExpensesDate':
              println('order is FinancialExpensesDate');
              break;
            case 'FingerprintCorrectionsData':
              println('order is FingerprintCorrectionsData');
              break;
            case 'HolidaysData':
              Get.to(()=> HolidayRequestPage(order: order,onClose: (){
                final PreviousRequestsController controller = Get.find();
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
              },));
              break;
            case 'LetterDate':
              println('order is LetterDate');
              break;
            case 'LoansData':
              println('order is LoansData');
              break;
            case 'OvertimeData':
              println('order is OvertimeData');
              break;
            case 'OrderVisaData':
              println('order is OrderVisaData');
              break;

          }
        }else{
          SnackBars.showErrorSnackBar('error'.tr, 'cannot_update_order'.tr);
        }
      },
        child: PreviousRequestsItemWidget(order: order)) ;
  }
}

