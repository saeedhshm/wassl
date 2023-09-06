import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../getx_controllers/app_controller.dart';
import '../../../../getx_controllers/profile/user_menu_view_model.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../reusable_widgets/circular_widget.dart';
import '../../../reusable_widgets/dark_text_widget.dart';
import '../../../reusable_widgets/load_image.dart';
import '../../settings/settings_page.dart';

class HeaderWidget extends StatelessWidget {
   HeaderWidget({
    Key? key,
  }) : super(key: key);


   final UserMenuViewModel menuViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularWidget(
                  size: 100,
                  child: ImageController(menuViewModel.userImage,color: AppColors.orangeColorInCalend).loadImage(),
                ),
              ],
            ),
            Positioned(
              left: 0,
              child: InkWell(
                onTap: (){
                  Get.to(()=>SettingsPage());
                },
                child: SizedBox(
                    width: 45,
                    child: Image.asset('assets/images/profile/setting.png')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        DarkTextWidget(menuViewModel.fullName,fontSize: 20,),
        const SizedBox(height: 0,),
        DarkTextWidget(menuViewModel.jobName,fontSize: 15,),
        const SizedBox(height: 20,),
      ],
    );
  }
}