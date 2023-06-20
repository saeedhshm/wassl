import 'package:flutter/material.dart';

import '../../../../helpers/constants/app_colors.dart';


class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 0.5,
      color: AppColors.lightGreyTextColor.withOpacity(0.35),
    );
  }
}