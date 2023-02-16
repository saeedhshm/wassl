import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:wassl/getx_controllers/orders/load_order_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/exceptions/custom_exception.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class NewLoanOrder extends StatelessWidget {
  
   NewLoanOrder({Key? key}) : super(key: key);

   final LoanOrderController controller = Get.put(LoanOrderController());
   final dateCtrl = TextEditingController();
   final fileCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // controller.loading.value = false;
    return Scaffold(
      body: Column(
        children: [
          MainAppbarWidget(
            'order_laon',
            onBack: () {
              Get.back();
            },
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width:double.infinity,
                      child: LocalizedText(
                        'loan_details'.tr,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold
                            ),
                      ),
                    ),
                  ),
                  // DropDownMenu(textHint: 'loan_type'.tr,)
                  DropDownWidget(
                    hintText: 'loan_type'.tr,
                    items:  ['residential'.tr, 'personal'.tr,'emergency'.tr,'travelling_fees'.tr],
                    onSelectedIndex: (int i) {
                      controller.loanType = i+1;
                      println(controller.loanType);
                    },
                    prefixIcon: const SizedBox(
                        width: 5,
                        height: 35,
                        child:
                            SvgWidget('assets/images/loan_type.svg')),
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldWithIcons(
                    prefixIcon: const SvgWidget('assets/images/money_on_hand.svg'),
                    hintText: 'value'.tr,
                    keyboardType: TextInputType.number,
                    onChange: (value){
                      controller.amount = value;
                    },
                    suffixIcon: const SizedBox(
                      width: 25,
                      child: Center(
                        child: Text('ر.س',style: TextStyle(
                          color: Colors.grey
                        ),),
                      ),
                    ),

                  ),
                  const SizedBox(height: 15,),
                  InkWell(
                    onTap: () async {
                      var selectedDate = await showMonthYearPicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                      controller.loanStartingDate = selectedDate ?? controller.loanStartingDate;
                      if(controller.loanStartingDate != null){
                        dateCtrl.text = '${controller.loanStartingDate?.year}-${controller.loanStartingDate?.month}-${controller.loanStartingDate?.day} ';
                      }else{
                        dateCtrl.text = '';
                      }
                    },
                    child: TextFormFieldWithIcons(
                      prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                      hintText: 'start_cutting_amount'.tr,

                      enabled: false,
                      controller: dateCtrl,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormFieldWithIcons(
                    prefixIcon: const SvgWidget('assets/images/money_on_hand.svg'),
                    hintText: 'installmentMonthlyAmount'.tr,
                    keyboardType: TextInputType.number,
                    onChange: (value){
                      controller.installmentMonthlyAmount = value;
                    },
                    suffixIcon: const SizedBox(
                      width: 25,
                      child: Center(
                        child: Text('ر.س',style: TextStyle(
                            color: Colors.grey
                        ),),
                      ),
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width:double.infinity,
                      child: LocalizedText(
                        'calculate_loan_installment_way'.tr,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  TextFormFieldWithIcons(
                    prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                    hintText: 'monthly_installment_method'.tr,
                    // keyboardType: TextInputType.number,
                    onChange: (value){
                      controller.monthlyInstallmentMethod = value;
                    },


                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width:double.infinity,
                      child: LocalizedText(
                        'clear_reason'.tr,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  TextFormFieldWithIcons(
                    prefixIcon: SizedBox(
                      child: Image.asset('assets/images/conversation.png'),
                    ),
                    maxLines: 5,
                    hintText: 'the_reason'.tr,
                    height: 130,
                    onChange: (value){
                      controller.reason = value;
                    },
                  ),
                  const SizedBox(height: 15,),
                  InkWell(
                    onTap: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );

                      if (result != null) {
                        String filePath = result.files.single.path ?? '';

                        if(filePath.isNotEmpty){
                          controller.filePath = filePath;
                          fileCtrl.text = filePath.split('/').last;
                          // File file = File(filePath);
                        }

                      } else {
                        // User canceled the picker
                      }
                    },
                    child: TextFormFieldWithIcons(
                      controller: fileCtrl,
                      enabled: false,
                      prefixIcon: SizedBox(
                        child: Image.asset('assets/images/attach.png'),
                      ),
                      hintText: 'attach_file'.tr,


                    ),
                  ),
                  const SizedBox(height: 15,),
                  Obx(() => controller.loading.value ? SendingLoadingWidget() : InkWell(
                    onTap: ()async{
                     try{
                       await controller.addNewLoad();
                       SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
                       Future.delayed(Duration(milliseconds: 4600),(){
                         Get.back();
                       });
                       // Get.back();
                     }on NoInternetException catch(e){
                       SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

                     }on CustomException catch(e){
                       SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

                     }finally{
                       controller.loading.value = false;
                     }
                    },
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child:Text(
                            'send'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: greenGradiantAppBar,),
                    ),
                  )),
                  const SizedBox(height: 25,),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
