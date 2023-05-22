import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/covenants/covenants_controller.dart';
import 'package:wassl/views/pages/covenant/widgets/convenant_item.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../consts_widgets/loading_widgets.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../../reusable_widgets/no_items.dart';

class CovenantPage extends StatelessWidget {

  CovenantPage({Key? key}) : super(key: key){
    controller.getAllCovenants();
  }

  final CovenantsController controller = Get.put(CovenantsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("Custodys",onBack: (){
            Get.back();
          },),
          Expanded(child: Obx(()=>Container(
            color: AppColors.mainBackgroundColor,
            child: controller.appController.loading.value ?
            const Center(
              child: SendingLoadingWidget(),
            ) :
            controller.myCovenants.value.covenants.isNotEmpty ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (_,index){
                    var cov = controller.myCovenants.value.covenants[index];
                    return CovenantItemWidget(covenant: cov,);
                  },
                  separatorBuilder: (_,index){
                    return const SizedBox(height: 16,);
                  },
                  itemCount: controller.myCovenants.value.covenants.length),
            ) : NoItemsWidget(noItemsFound: 'no_custodys'.tr,),
          )))
        ],
      ),
    );
  }
}
