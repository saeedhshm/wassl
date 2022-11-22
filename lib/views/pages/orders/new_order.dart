import 'package:flutter/material.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../reusable_widgets/list_profile_item_widget.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget('order_type'),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      LocalizedText('finance',textStyle: const TextStyle(
                        color: AppColors.lightGreyTextColor
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
