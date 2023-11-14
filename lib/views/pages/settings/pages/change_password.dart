import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/exceptions/passwords_exceptions.dart';
import '../../../reusable_widgets/custom_text_form_field.dart';
import '../../../reusable_widgets/dark_text_widget.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/dialogs_messages/snack_bars.dart';

class ChangePasswordPage extends StatefulWidget {


   ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final AppController appController = Get.find();

  final currentPasswordCrtl = TextEditingController();
  final newPasswordCrtl = TextEditingController();
  final confirmPasswordCrtl = TextEditingController();

  var securePassword = true;


  var validateNewPassword = true;
  var validateCurrentPassword = true;
  var validateConfirmPassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() => IgnorePointer(
      ignoring: appController.loading.value,
      child: Scaffold(
        body: Column(

          children: [
            MainAppbarWidget(
              'profile'.tr,
              onBack: () {
                Get.back();
              },
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(

                child: Container(
                  height: Get.height - 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DarkTextWidget('settings'.tr,fontSize: 18,fontWeight: FontWeight.bold,),
                      const SizedBox(height: 16,),
                      Text('current_password'.tr,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 16,),
                      CustomTextFormField(
                        hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                        labelText: null,
                        secureText: securePassword,
                        controller: currentPasswordCrtl,
                        isValideField: validateCurrentPassword,
                        errorMessage: 'oldPassword_didnt_match_currentPassword'.tr,
                        suffixIcon:  InkWell(
                          onTap: (){
                            securePassword = !securePassword;
                            setState(() {

                            });
                          },
                          child:  Icon(securePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: AppColors.lightGreyTextColor,),
                        ),
                        // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                      ),
                      const SizedBox(height: 16,),
                      Text('new_password'.tr,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 16,),
                      CustomTextFormField(
                        hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                        labelText: null,
                        secureText: securePassword,
                        controller: newPasswordCrtl,
                        isValideField: validateNewPassword,
                        errorMessage: 'password less than 6 characters'.tr,
                        suffixIcon:  InkWell(
                          onTap: (){
                            securePassword = !securePassword;
                            setState(() {

                            });
                          },
                          child:  Icon(securePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: AppColors.lightGreyTextColor,),
                        ),
                        // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                      ),
                      const SizedBox(height: 16,),
                      Text('confirm_password'.tr,style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 16,),
                      CustomTextFormField(
                        hintText: '⋆⋆⋆⋆⋆⋆⋆⋆⋆⋆',
                        labelText: null,
                        secureText: securePassword,
                        errorMessage: 'newPassword_didnt_match_confirmPassword'.tr,
                        isValideField: validateConfirmPassword,
                        controller: confirmPasswordCrtl,
                        suffixIcon:  InkWell(
                          onTap: (){
                            securePassword = !securePassword;
                            setState(() {

                            });
                          },
                          child:  Icon(securePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,color: AppColors.lightGreyTextColor,),
                        ),
                        // suffixIcon: Icon(Icons.visibility_off_outlined,color: AppColors.lightGreyTextColor,),
                      ),
                      const Spacer(),
                      appController.loading.value ? const SendingLoadingWidget() : InkWell(
                        onTap: _changeMyPassword,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: greenGradiantAppBar,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child:Text('change_password'.tr,style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  void _changeMyPassword() async {
     validateNewPassword = true;
     validateCurrentPassword = true;
     validateConfirmPassword = true;

    try{
    var respons = await  appController.changeMyPassword(currentPassword: currentPasswordCrtl.text, newPassword: newPasswordCrtl.text, confirmPassword: confirmPasswordCrtl.text);
    SnackBars.showConfirmedSnackBar('success'.tr, 'password_changed_success'.tr);
    }on NoInternetException catch(e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on CurrentPasswordException{
      validateCurrentPassword = false;
    }on PasswordLengthException{
      validateNewPassword = false;
    }on NewPassConfirmedPassException{
      validateConfirmPassword = false;
    }catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'password_didnt_change'.tr);
    }finally{
      appController.loading.value = false;
      setState(() {

      });
    }


  }
}
