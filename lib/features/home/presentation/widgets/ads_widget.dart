import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/models/ads/Ad.dart';
import 'package:wassl/views/pages/ads/ads_page.dart';

import '../../../../features/home/presentation/manager/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../views/reusable_widgets/load_image.dart';

class AdsWidget extends StatelessWidget {
  AdsWidget({Key? key}) : super(key: key);
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
          padding: const EdgeInsets.all(16.0),
          child: controller.ads.value.ads.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'the_ads'.tr,
                            style: const TextStyle(
                                color: AppColors.iconsColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: controller.ads.value.ads
                            .map(
                              (e) => ItemWidget(e),
                            )
                            .toList(),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
        ));
  }
}

class ItemWidget extends StatelessWidget {
  final AdItem adItem;
  const ItemWidget(
    this.adItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.to(() => AdDetailsPage(adItem)),
          child: Container(
            width: Get.width * 0.5,
            margin: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 0.5,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: Get.width * 0.2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: ImageController(
                      adItem.image,
                      fit: BoxFit.cover,
                    ).loadImage(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${adItem.title}',
                        style: const TextStyle(
                            color: AppColors.darkGreyTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text(
                            '${adItem.dateTime}',
                            style: const TextStyle(
                                color: AppColors.lightGreyTextColor,
                                fontSize: 9),
                          ),
                        ],
                      ),
                      Text(
                        '${adItem.details}',
                        style: const TextStyle(
                            color: AppColors.lightGreyTextColor, fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
