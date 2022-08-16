import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    print(height);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 65 + height,
            decoration: BoxDecoration(
              color: AppColors.mainGreenColor
            ),
          )
        ],
      ),
    );
  }
}
