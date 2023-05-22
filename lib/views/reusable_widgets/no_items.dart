
import 'package:flutter/material.dart';

import '../../helpers/constants/app_colors.dart';

class NoItemsWidget extends StatelessWidget {
  const NoItemsWidget({
    Key? key,
    required this.noItemsFound
  }) : super(key: key);

  final String noItemsFound;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(noItemsFound,style: const TextStyle(
          color: AppColors.darkGreyTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),),
    );
  }
}