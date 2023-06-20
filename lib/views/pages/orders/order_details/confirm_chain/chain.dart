import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/orders/order_details/confirm_chain/widgets/comments_widgets.dart';
import 'package:wassl/views/pages/orders/order_details/confirm_chain/widgets/confirmation_widget.dart';

import '../../../../../getx_controllers/orders/order_details.dart';
import '../../../../../helpers/constants/print_ln.dart';
import '../../../../reusable_widgets/circular_widget.dart';
import '../../../../reusable_widgets/textfield_with_icons.dart';

class ConfirmChainFragment extends StatelessWidget {

   ConfirmChainFragment({Key? key}) : super(key: key);


  final heightBetweenWidgets = 10.0;
   final OrderDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child:controller.order.confirmation?.length == 0 ? Center(
          child: Text('no_chain_confirmation'.tr,style: TextStyle(
              color: AppColors.darkGreyTextColor,
              fontWeight: FontWeight.bold
          ),),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CommentsWidget(),
                SizedBox(height: heightBetweenWidgets,),
                SizedBox(height: heightBetweenWidgets,),
                ConfirmationWidget()
              ],
            ),
          ),
        ),
        color: AppColors.mainBackgroundColor,
      ),

    );
  }
}


