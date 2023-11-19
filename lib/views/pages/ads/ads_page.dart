import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

import '../../../models/ads/Ad.dart';
import '../../reusable_widgets/load_image.dart';

class AdDetailsPage extends StatelessWidget {

  final AdItem adItem;
  const AdDetailsPage(this.adItem,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                child: ImageController(
                  adItem.image,
                  fit: BoxFit.cover,

                ).loadImage(),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2)
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,

                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${adItem.title}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainGreenColor
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/images/ad_details/cal.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${adItem.dateTime}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreyTextColor
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${adItem.details}',
                  style: const TextStyle(
                    fontSize: 14,
                      color: AppColors.darkGreyTextColor
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



