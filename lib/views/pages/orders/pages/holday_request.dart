import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/holiday/holiday_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/orders/holday/holiday_type.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class HolidayRequestPage extends StatelessWidget {

  final controller = Get.put(HolidayController());
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  final fileCtrl = TextEditingController();

   HolidayRequestPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>IgnorePointer(
        ignoring: controller.appController.loading.value,
        child: Column(
          children: [
            MainAppbarWidget(
              'order_holiday',
              onBack: () {
                Get.back();
              },
            ),
            Expanded(
                child:controller.loadingHolidayTypes.value ?
                const Center(
                  child: SendingLoadingWidget(),
                ) : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width:double.infinity,
                                child: LocalizedText(
                                  'holiday_details'.tr,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            // DropDownMenu(textHint: 'loan_type'.tr,)
                            DropDownWidget(
                              hintText: 'holiday_type'.tr,
                              items:  controller.orderTypes.value.data!.map((e) => e.name ?? '').toList(),
                              onSelectedIndex: (int i) {
                                controller.selectedType = controller.orderTypes.value.data![i];
                              },
                              prefixIcon: const SizedBox(
                                  width: 5,
                                  height: 35,
                                  child:
                                  SvgWidget('assets/images/holidays.svg')),
                            ),
                            const SizedBox(height: 15,),

                            Row(
                              children: [
                                Expanded(child: InkWell(
                                  onTap: () async {
                                    var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100));
                                    controller.startDate = selectedDate ?? controller.startDate;
                                    if(controller.startDate != null){
                                      startDateCtrl.text = '${controller.startDate?.year}-${controller.startDate?.month}-${controller.startDate?.day} ';
                                    }else{
                                      startDateCtrl.text = '';
                                    }
                                  },
                                  child:TextFormFieldWithIcons(
                                    prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                    hintText: 'start'.tr,
                                    enabled: false,
                                    controller: startDateCtrl,
                                  ),

                                ),),
                                SizedBox(width: 16,),
                                Expanded(child: InkWell(
                                  onTap: () async {
                                    if(controller.startDate != null){
                                      var selectedDate = await showDatePicker(context: context, initialDate: controller.startDate ?? DateTime.now(), firstDate: controller.startDate ?? DateTime.now(), lastDate: DateTime(2100));
                                      controller.endDate = selectedDate ?? controller.endDate;
                                      if(controller.endDate != null){
                                        endDateCtrl.text = '${controller.endDate?.year}-${controller.endDate?.month}-${controller.endDate?.day} ';
                                      }else{
                                        endDateCtrl.text = '';
                                      }
                                    }else{
                                      SnackBars.showErrorSnackBar('error'.tr, 'select_start_date_first'.tr);
                                    }
                                  },
                                  child: TextFormFieldWithIcons(
                                    prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                    hintText: 'end'.tr,
                                    enabled: false,
                                    controller: endDateCtrl,

                                  ),
                                ),)
                              ],
                            ),
                            const SizedBox(height: 15,),



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
                                controller.holidayReason = value;
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
                            controller.appController.loading.value ? const Center(
                              child: SendingLoadingWidget(),
                            ) : InkWell(
                              onTap: _sendData,
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
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
                            ),
                            const SizedBox(height: 25,),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }

  _sendData() async {
    controller.appController.loading.value = true;
    try{
      await controller.sendHolidayRequest();
      SnackBars.showConfirmedSnackBar('success'.tr, 'holiday_request_added'.tr);
      Future.delayed(Duration(milliseconds: 4600),(){
        Get.back();
      });
    }on StartDateException {
      println('StartDateException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'StartDateException'.tr);
    }on ChooseTypeException {
      println('HolidayTypeException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayTypeException'.tr);
    }on EndDateException{
      println('EndDateException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'EndDateException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayReasonException'.tr);
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }finally{
      controller.appController.loading.value = false;
    }
  }
}
