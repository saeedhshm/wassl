import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

import '../../../../helpers/constants/app_colors.dart';

class PreviousRequestsItemWidget extends StatelessWidget {
  const PreviousRequestsItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text('leaving_request'.tr,style: TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
                Spacer(),
                Text('confirmed'.tr,style: TextStyle(
                  color: AppColors.mainGreenColor
                ),)
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgWidget('assets/images/pref_calendar_icon.svg'),
                ),
                Text('2022 /5/10',style: TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 16
                ),)
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('whole_day'.tr,
                        style: TextStyle(
                          color: AppColors.darkGreyTextColor
                        ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('sickـleave'.tr,
                          style: TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('2_days'.tr,
                          style: TextStyle(
                              color: AppColors.darkGreyTextColor
                          ),),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.mainBackgroundColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
