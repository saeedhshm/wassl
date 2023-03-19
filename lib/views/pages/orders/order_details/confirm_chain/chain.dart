import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';

import '../../../../reusable_widgets/circular_widget.dart';
import '../../../../reusable_widgets/textfield_with_icons.dart';

class ConfirmChainFragment extends StatelessWidget {

   ConfirmChainFragment({Key? key}) : super(key: key);

  final reasonCtrl= TextEditingController();
  final hieghtBetweenWidgets = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('comments'.tr),
                SizedBox(height: hieghtBetweenWidgets,),
                Row(
                  children: [
                    CircularWidget(
                      size: 50,
                      child: Image.asset('assets/images/profile/1.png'),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormFieldWithIcons(
                        prefixIcon: SizedBox(
                          child: Image.asset(
                              'assets/images/conversation.png'),
                        ),
                        maxLines: 1,
                        hintText: 'add_comment'.tr,
                        controller: reasonCtrl,
                        onChange: (value) {
                          // controller.reason = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hieghtBetweenWidgets,),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        gradient: greenGradiantAppBarSecond,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 25),
                        child: Text('send'.tr,style: const TextStyle(
                            color: Colors.white
                        ),),
                      ),
                    )
                  ],
                ),
                SizedBox(height: hieghtBetweenWidgets,),
                SizedBox(height: hieghtBetweenWidgets,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.borderTextFieldColor,width: 0.5)
                  ),
                  child: Column(
                    children: [
                      ChainItemWidget(
                          hieghtBetweenWidgets: hieghtBetweenWidgets,
                        name: 'حسين علي',
                        job: '12007 - مطور وجهات',
                        image: 'assets/images/profile/1.png',
                        date: '5/10/2022',
                        time: '10:20 ص',
                      ),
                      ChainItemWidget(
                        hieghtBetweenWidgets: hieghtBetweenWidgets,
                        name: 'حسين علي',
                        job: '12007 - مطور وجهات',
                        image: 'assets/images/profile/1.png',
                        date: '5/10/2022',
                        time: '10:20 ص',
                      ),
                      ChainItemWidget(
                        hieghtBetweenWidgets: hieghtBetweenWidgets,
                        name: 'حسين علي',
                        job: '12007 - مطور وجهات',
                        image: 'assets/images/profile/1.png',
                        date: '5/10/2022',
                        time: '10:20 ص',
                      ),
                      ChainItemWidget(
                        hieghtBetweenWidgets: hieghtBetweenWidgets,
                        name: 'حسين علي',
                        job: '12007 - مطور وجهات',
                        image: 'assets/images/profile/1.png',
                        date: '5/10/2022',
                        time: '10:20 ص',
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        color: AppColors.mainBackgroundColor,
      ),

    );
  }
}

class ChainItemWidget extends StatelessWidget {

  final String image;
  final String name,job,date,time;

  const ChainItemWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.job,
    required this.date,
    required this.time,
    // required this.name,
    required this.hieghtBetweenWidgets,
  }) : super(key: key);

  final double hieghtBetweenWidgets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircularWidget(
            size: 50,
            child: Image.asset(image),
          ),
          SizedBox(width: hieghtBetweenWidgets,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,style: const TextStyle(
                  color: AppColors.darkGreyTextColor
              ),),
              Text(job,style: const TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 13
              ),),
              Container(
                decoration: BoxDecoration(
                  gradient: greenGradiantAppBarSecond,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.5,horizontal: 10),
                  child: Text('confirmt'.tr,style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13
                  ),),
                ),
              )
            ],
          )),
          Column(
            children: [
              Text(date,style: const TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 13
              ),),
              Text(time,style: const TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 13
              ),),
            ],
          )
        ],
      ),
    );
  }
}
