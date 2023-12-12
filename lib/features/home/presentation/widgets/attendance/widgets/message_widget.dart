import 'package:flutter/material.dart';

import '../../../../../../helpers/constants/app_colors.dart';

class AttendanceMessageWidget extends StatelessWidget {
  final String message;
  const AttendanceMessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(message,
            style: const TextStyle(
                color: AppColors.darkGreyTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
