import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../helpers/constants/app_colors.dart';
import '../../../../../consts_widgets/gradiants.dart';
import '../../../../../reusable_widgets/circular_widget.dart';

class ChainItemWidget extends StatelessWidget {

  final String image;
  final String name,job,date,time;
  final int confirmStatus;
  final String? hrComment;

  const ChainItemWidget({
    Key? key,
    required this.name,
    required this.image,
    required this.job,
    required this.date,
    required this.time,
    required this.confirmStatus,
    required this.hieghtBetweenWidgets,
    this.hrComment,
  }) : super(key: key);

  final double hieghtBetweenWidgets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularWidget(
                size: 50,
                child: Image.asset(image),
              ),
              SizedBox(width: hieghtBetweenWidgets,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,style: const TextStyle(
                                color: AppColors.darkGreyTextColor
                            ),),

                            Container(
                              decoration: BoxDecoration(
                                gradient:confirmStatus == 1 ? grayGradiantAwait : confirmStatus == 2 ? greenGradiantAppBarSecond : redGradiantRejected ,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical:'lang_code'.tr == 'ar' ? 2 : 5,horizontal: 10),
                                child: Text(confirmStatus == 1 ? 'await_status'.tr : confirmStatus == 2 ? 'confirmt'.tr : 'disapproved'.tr,style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13
                                ),),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
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
                        ),
                      ],
                    ),
                    SizedBox(height: hieghtBetweenWidgets,),
                    hrComment != null ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.borderTextFieldColor,width: 0.5)
                      ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('comment'.tr +' : '),
                              Expanded(child: Text(hrComment.toString())),

                            ],
                          ),
                        )) : SizedBox(),
                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}