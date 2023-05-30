import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';

class AdsWidget extends StatelessWidget {

  AdsWidget({Key? key}) : super(key: key);
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0),
            child: Row(
              children: [
                Text(
                  'the_ads'.tr,
                  style: const TextStyle(
                      color: AppColors.darkGreyTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Stack(
              children: [
                Positioned(
                    bottom:0,
                    left: 0,
                    child: Image.asset('assets/images/prosedures/adds.png',width: 50,)),
                Column(
                  children: [
                    ItemWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.mainBackgroundColor
                        ),
                      ),
                    ),
                    ItemWidget(),


                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {

  final String adTitle = 'عنوان الاعلان';
  final String adBody = 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها. ولذلك يتم استخدام طريقة لوريم إيبسوم لأنها تعطي توزيعاَ طبيعياَ';
  const ItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(adTitle,style: TextStyle(
              color: AppColors.darkGreyTextColor,
              fontWeight: FontWeight.bold

          ),),
          Row(
            children: [
              Text('25 مارس 2023',style: TextStyle(
                  color: AppColors.lightGreyTextColor,
                  fontSize: 12
              ),),

            ],
          ),
          Text(adBody,style: TextStyle(
              color: AppColors.lightGreyTextColor,
              fontSize: 12
          ),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
        ],
      ),
    );
  }
}
