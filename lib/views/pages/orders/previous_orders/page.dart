import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/order_details.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/models/orders/holiday.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/order_details/order_details.dart';
import 'package:wassl/views/pages/orders/previous_orders/team_orders.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/order_item/order_item_widget.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/previous_orders.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets/tabs.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../reusable_widgets/main_appbar.dart';


class PreviousRequestsPage extends StatefulWidget {

  final bool fromHomePage;
   PreviousRequestsPage({Key? key,this.fromHomePage = false}) : super(key: key){
     // retrieveAllOrders();
   }

  @override
  State<PreviousRequestsPage> createState() => _PreviousRequestsPageState();
}

class _PreviousRequestsPageState extends State<PreviousRequestsPage> {


  final PreviousRequestsController controller = Get.put(PreviousRequestsController());




   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.retrieveAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Column(
        children: [
          MainAppbarWidget(
            'previous_requests'.tr,
            onBack:widget.fromHomePage ? (){
              Get.back();
            } : null,
          ),
          controller.previousTeamRequests.value.orders.isNotEmpty ? TabsWidget() : const SizedBox(),
         controller.myOrdersSelected.value ?
         Expanded(child: PreviousOrdersWidget()) : Expanded(child: TeamOrderPage()),
          SizedBox(height: widget.fromHomePage ? 0 : 100,)
        ],
      )),
    );
  }
}





