import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class ExtraWorkRequest extends StatelessWidget {
  const ExtraWorkRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'extra_work_request',
            onBack: () {
              Get.back();
            },
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width:double.infinity,
                              child: LocalizedText(
                                'elements'.tr,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          // DropDownMenu(textHint: 'loan_type'.tr,)

                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                            hintText: 'date'.tr,


                          ),
                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon: const SvgWidget('assets/images/extra_work.svg'),
                            hintText: 'shift_or'.tr,
                            // height: 130,
                          ),
                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon: const SvgWidget('assets/images/extra_work.svg'),
                            hintText: 'number_of_hours'.tr,
                            // height: 130,
                          ),
                          const SizedBox(height: 15,),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width:double.infinity,
                              child: LocalizedText(
                                'clear_reason'.tr,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          TextFormFieldWithIcons(
                            prefixIcon: SizedBox(
                              child: Image.asset('assets/images/conversation.png'),
                            ),
                            maxLines: 5,
                            hintText: 'the_reason'.tr,
                            height: 130,
                          ),
                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon: SizedBox(
                              child: Image.asset('assets/images/attach.png'),
                            ),
                            hintText: 'attach_file'.tr,


                          ),
                          const SizedBox(height: 15,),
                          const SizedBox(height: 15,),
                          const SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  'send'.tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: greenGradiantAppBar,),
                          ),
                          const SizedBox(height: 25,),
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