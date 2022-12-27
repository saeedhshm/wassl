import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class NewLoanOrder extends StatelessWidget {
  const NewLoanOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'order_laon',
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
                            'loan_details'.tr,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold
                                ),
                          ),
                        ),
                      ),
                      // DropDownMenu(textHint: 'loan_type'.tr,)
                      DropDownWidget(
                        hintText: 'loan_type'.tr,
                        items: const ['done', 'not done'],
                        onSelectedIndex: (int i) {},
                        prefixIcon: const SizedBox(
                            width: 5,
                            height: 35,
                            child:
                                SvgWidget('assets/images/loan_type.svg')),
                      ),
                      const SizedBox(height: 15,),
                      TextFormFieldWithIcons(
                        prefixIcon: const SvgWidget('assets/images/money_on_hand.svg'),
                        hintText: 'value'.tr,
                        suffixIcon: const SizedBox(
                          width: 25,
                          child: Center(
                            child: Text('ر.س',style: TextStyle(
                              color: Colors.grey
                            ),),
                          ),
                        ),

                      ),
                      const SizedBox(height: 15,),
                      TextFormFieldWithIcons(
                        prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                        hintText: 'start_cutting_amount'.tr,


                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:double.infinity,
                          child: LocalizedText(
                            'calculate_loan_installment_way'.tr,
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      DropDownWidget(
                        hintText: 'month_installment'.tr,
                        items: const ['done', 'not done'],
                        onSelectedIndex: (int i) {},
                        prefixIcon: const SizedBox(
                            width: 5,
                            height: 35,
                            child:
                            SvgWidget('assets/images/pref_calendar_icon.svg')),
                      ),
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
