import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../models/orders/order_type.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class CustodyLeavingOrder extends StatelessWidget {
  const CustodyLeavingOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'order_custody_leaving',
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
                                'custody_details'.tr,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          // DropDownMenu(textHint: 'loan_type'.tr,)
                          DropDownWidget(
                            hintText: 'custody_type'.tr,
                            items:  [OrderType(id: 1)..name = 'done',OrderType(id: 2)..name =  'not done'],
                            onSelectedIndex: (value) {},
                            prefixIcon: const SizedBox(
                                width: 5,
                                height: 35,
                                child:
                                SvgWidget('assets/images/custody.svg')),
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
                          SendButtonWidget(_addNewRequest),
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

  _addNewRequest(){}
}