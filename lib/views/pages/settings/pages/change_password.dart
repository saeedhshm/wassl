import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';

import '../../../reusable_widgets/custom_text_form_field.dart';
import '../../../reusable_widgets/dark_text_widget.dart';
import '../../../reusable_widgets/main_appbar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          MainAppbarWidget(
            'profile'.tr,
            onBack: () {
              Get.back();
            },
          ),
          Expanded(child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DarkTextWidget('settings'.tr,fontSize: 18,fontWeight: FontWeight.bold,),
                SizedBox(height: 16,),
                Text('current_password'.tr,style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                  labelText: null,
                  secureText: true,
                  // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                ),
                SizedBox(height: 16,),
                Text('new_password'.tr,style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                  labelText: null,
                  secureText: true,
                  // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                ),
                SizedBox(height: 16,),
                Text('confirm_password'.tr,style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 16,),
                CustomTextFormField(
                  hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                  labelText: null,
                  secureText: true,
                  // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                ),
               Spacer(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: greenGradiantAppBar,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text('change_password'.tr,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
