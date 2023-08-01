import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';

import '../../../../getx_controllers/app_controller.dart';
import '../../../reusable_widgets/dark_text_widget.dart';
import '../../../reusable_widgets/main_appbar.dart';

class ChangeLangPage extends StatelessWidget {

   ChangeLangPage({Key? key}) : super(key: key);

  final AppController appController = Get.find();

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
                      LanguageItemWidget(title: 'arabic'.tr,
                        onChange: (){
                          appController.setLanguage('ar', 'SA');
                        },isSelected: 'lang_code'.tr == 'ar',),
                      LanguageItemWidget(title: 'english'.tr,
                        onChange: (){
                          appController.setLanguage('en', 'US');
                        },isSelected: 'lang_code'.tr == 'en',),
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

class LanguageItemWidget extends StatelessWidget {

  final String title;
  final Function ()onChange;
  final AppController appController = Get.find();
  final bool isSelected;
  LanguageItemWidget({super.key,required this.title,required this.onChange,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(title),
                const Spacer(),
               isSelected ? const Icon(Icons.check) : SizedBox()
              ],
            ),
          ),
          Container(width: double.infinity,height: 0.5,color: Colors.grey,),
        ],
      ),
    );
  }
}

