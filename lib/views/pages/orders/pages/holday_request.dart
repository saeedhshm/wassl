import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts/gradiants.dart';

import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class HolidayRequestPage extends StatelessWidget {
  const HolidayRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'order_holiday',
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
                                'holiday_details'.tr,
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          // DropDownMenu(textHint: 'loan_type'.tr,)
                          DropDownWidget(
                            hintText: 'holiday_type'.tr,
                            items: const ['done', 'not done'],
                            onSelectedIndex: (int i) {},
                            prefixIcon: const SizedBox(
                                width: 5,
                                height: 35,
                                child:
                                SvgWidget('assets/images/holidays.svg')),
                          ),
                          const SizedBox(height: 15,),

                          Row(
                            children: [
                              Expanded(child: TextFormFieldWithIcons(
                                prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                hintText: 'start'.tr,


                              ),),
                              SizedBox(width: 16,),
                              Expanded(child: TextFormFieldWithIcons(
                                prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                hintText: 'end'.tr,


                              ),)
                            ],
                          ),
                          const SizedBox(height: 15,),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    LocalizedText(
                                      'traviling_ticket'.tr,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Spacer(),
                                    Directionality(textDirection: TextDirection.ltr, child: Switch(value: false, onChanged: (value){},activeColor: AppColors.mainGreenColor,))
                                  ],
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: double.infinity,
                                  height: 0.5,
                                ),
                                Row(
                                  children: [
                                    LocalizedText(
                                      'go_return'.tr,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Spacer(),
                                   Directionality(textDirection: TextDirection.ltr, child: Switch(value: false, onChanged: (value){},activeColor: AppColors.mainGreenColor,))
                                  ],
                                ),
                              ],
                            ),
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
