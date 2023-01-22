import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../reusable_widgets/dark_text_widget.dart';
import '../../../reusable_widgets/main_appbar.dart';

class ChangeLangPage extends StatelessWidget {
  const ChangeLangPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'profile'.tr,
            onBack: () {
              Get.back();
            },
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DarkTextWidget('change_lang'.tr,fontSize: 18,fontWeight: FontWeight.bold,),
                const SizedBox(height: 16,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('arabic'.tr),
                            const Spacer(),
                            const Icon(Icons.check)
                          ],
                        ),
                      ),
                      Container(width: double.infinity,height: 0.5,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text('english'.tr),
                            const Spacer(),
                            // const Icon(Icons.check)
                          ],
                        ),
                      ),
                      Container(width: double.infinity,height: 0.5,color: Colors.grey,),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
