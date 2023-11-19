import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wassl/getx_controllers/docs/docs_get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/documents/widgets/doc_item.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/main_appbar.dart';
import '../../reusable_widgets/no_items.dart';

class DocsPage extends StatelessWidget {

  final controller = Get.put(DocsController());

  DocsPage({Key? key}) : super(key: key){
    controller.getAllDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget("docs",onBack: (){
            Get.back();
          },),
          Expanded(child: Obx(()=>Container(
            color: AppColors.mainBackgroundColor,
            child: controller.appController.loading.value ?
            const Center(
              child: SendingLoadingWidget(),
            ) :
            controller.myDocs.value.documents.isNotEmpty ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                  itemBuilder: (_,index){
                    var doc = controller.myDocs.value.documents[index];
                    return DocItemWidget(doc: doc);
                  },
                  separatorBuilder: (_,index){
                    return const SizedBox(height: 16,);
                  },
                  itemCount: controller.myDocs.value.documents.length),
            ) : NoItemsWidget(noItemsFound: 'no_docs_yet'.tr,),
          )))
        ],
      ),
    );
  }
}



