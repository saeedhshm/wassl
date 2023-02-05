import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/orders/previous_orders/widgets.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../reusable_widgets/main_appbar.dart';

class PreviousRequestsPage extends StatelessWidget {

  final PreviousRequestsController controller = Get.find<PreviousRequestsController>();
   PreviousRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'previous_requests'.tr,

          ),
          Expanded(child: Center(
            child: Text('no_previous_requests'.tr,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: AppColors.darkGreyTextColor
            ),),
          ))
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          itemCount: 0,
          itemBuilder: (_,index){
            return index == 4 ? SizedBox(height: 100,) : PreviousRequestsItemWidget() ;
          }, separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20,);
        },
        ),
      ),
    );
  }
}
