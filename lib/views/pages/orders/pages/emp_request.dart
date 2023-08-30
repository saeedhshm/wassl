import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/icons/calendar_icon.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../models/orders/order_type.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/icons/chat_icon.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class EmploymentRequest extends StatelessWidget {
  const EmploymentRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'emp_request',
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
                                'emp_details'.tr,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          // DropDownMenu(textHint: 'loan_type'.tr,)
                          DropDownWidget(
                            hintText: 'job_title'.tr,
                            items:  [OrderType(id: 1)..name = 'done', OrderType(id: 2)..name = 'not done'],
                            onSelectedIndex: (value) {},
                            prefixIcon: const SizedBox(
                                width: 5,
                                height: 35,
                                child:
                                SvgWidget('assets/images/employment.svg')),
                          ),
                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon:  SizedBox(height: 30,child: Image.asset('assets/images/profile/1.png')),
                            hintText: 'employees_numb'.tr,
                            // height: 130,
                          ),
                          const SizedBox(height: 15,),
                          TextFormFieldWithIcons(
                            prefixIcon: const PrefCalendarIcon(),
                            hintText: 'join_date'.tr,


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
                            prefixIcon: const SizedBox(
                              child: ChatConversationIcon(),
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