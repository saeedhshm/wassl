import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class LocationIcon extends StatelessWidget {

  final Color? color;
  const LocationIcon({this.color = AppColors.mainOrangeColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/ad_details/icon.png',color: color,);
  }
}
