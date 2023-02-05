import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_controllers/app_controller.dart';
import '../reusable_widgets/svg_widget.dart';

class UpdatingAppPage extends StatelessWidget {

  final AppController controller = Get.find();

   UpdatingAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      // height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: SizedBox(
                width: 250,
                height: 200,
                child: SvgWidget("assets/images/wasl.svg"),
              ),
            ),
            Text('outdated_version'.tr,style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
            InkWell(
              onTap: (){
                controller.gotoStore();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('update'.tr,style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),),
                          const Icon(Icons.update,color: Colors.red,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),



          ],
        ),
      ),
    ) ;
  }
}
