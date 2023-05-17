import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wassl/getx_controllers/docs/docs_get.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/load_image.dart';

import '../../../helpers/constants/app_colors.dart';
import '../../reusable_widgets/main_appbar.dart';

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
          // MainAppbarWidget(
          //   'request_type'.tr,
          //   // onBack: () {
          //   //   Get.back();
          //   // },
          // ),
          Expanded(child: Obx(()=>Container(

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
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        children: [
                          Text(doc.name ?? '')
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_,index){
                    return const SizedBox();
                  },
                  itemCount: controller.myDocs.value.documents.length),
            ) : Center(
              child: Text('no_docs_yet'.tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontWeight: FontWeight.bold
              ),),
            ),
          )))
        ],
      ),
    );
  }
}
