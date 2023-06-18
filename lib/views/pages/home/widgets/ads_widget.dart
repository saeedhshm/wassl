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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
                ItemWidget(),
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
    return Row(
      children: [
        Container(
          width: Get.width * 0.5,
          margin: EdgeInsets.all(1.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: const Offset(0,1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: Get.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset('assets/images/placeholders/car.png',fit: BoxFit.cover,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(adTitle,style: TextStyle(
                        color: AppColors.darkGreyTextColor,
                        fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),),
                    Row(
                      children: [
                        Text('25 مارس 2023',style: TextStyle(
                            color: AppColors.lightGreyTextColor,
                            fontSize: 9
                        ),),

                      ],
                    ),
                    Text(adBody,style: TextStyle(
                        color: AppColors.lightGreyTextColor,
                        fontSize: 10
                    ),maxLines: 2,overflow: TextOverflow.ellipsis,softWrap: false,),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10,)
      ],
    );
  }
}
