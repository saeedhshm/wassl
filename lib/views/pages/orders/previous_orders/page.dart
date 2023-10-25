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
import '../../../reusable_widgets/app_bars/app_bar_with_icon.dart';
import '../../../reusable_widgets/custom_radio_button/custom_radio_button.dart';
import '../../../reusable_widgets/icons/back_arrow.dart';
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
      // appBar: AppBar(
      //   elevation: 0,
      // ),
      body: Obx(()=>Column(
        children: [

          AppbarWithTrailingIconsWidget(
            'previous_requests'.tr,
            children: [
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: 500,
                        // color: Colors.black,
                        child: Column(
                          children: [
                            Container(
                              // color: Colors.white,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(height: 25,),
                                      Container(
                                        height: 25,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                  Positioned(
                                      top: 0,
                                      left: 26,
                                      child: InkWell(
                                        onTap:(){
                                          Get.back();
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                                child: Image.asset(
                                                  'assets/images/filters/2.png',
                                                  width: 10,
                                                )),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50)
                                          ),

                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: ListView.builder
                                  (
                                  itemCount: controller.menuItems.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Obx(() => ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 36),
                                      onTap: (){

                                        controller.groupValue = controller.menuItems[index];
                                      },
                                      trailing: CustomRadioButton<ListItem>(

                                        value: controller.menuItems[index],
                                        groupValue: controller.groupValue,
                                        onChanged: (ListItem? value) {
                                          controller.groupValue = value!;

                                        },
                                      ),
                                      title: Text('${controller.menuItems[index].name}'.tr,style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    child: Image.asset(
                      'assets/images/filters/1.png',
                      width: 22,
                    )),
              ),
              SizedBox(width: 16,),
              widget.fromHomePage ? InkWell(
                onTap: (){
                  Get.back();
                },
                child: const BackArrowIcon(width: 40,),
              ) : const SizedBox(),
            ],

          ),
          controller.hasTeamRequests.value ? TabsWidget() : const SizedBox(),
         controller.myOrdersSelected.value ?
         Expanded(child: PreviousOrdersWidget()) : Expanded(child: TeamOrderPage()),
          SizedBox(height: widget.fromHomePage ? 0 : 100,)
        ],
      )),
    );
  }
}





class ListItemWidget extends StatelessWidget {

  final ListItem item;
  ListItem? groupValue;

  ListItemWidget(this.item,{super.key,this.groupValue});

  @override
  Widget build(BuildContext context) {

    return ListTile(

      trailing: Radio<ListItem>(
        value: item,
        groupValue: groupValue, // TODO: Add logic for radio button selection
        onChanged: (ListItem? value) {
          // TODO: Handle radio button selection
          groupValue = value;
        },
      ),
      title: Text(item.name.tr),
    );
  }
}

class ListItem{
  String name;
  int status;
  bool isSelected;

  ListItem(this.name, this.status,this.isSelected);
}