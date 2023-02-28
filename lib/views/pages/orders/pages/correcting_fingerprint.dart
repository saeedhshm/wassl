import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/finger_print_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/models/orders/order_type.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/finger_print.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class CorrectingFingerprintRequest extends StatelessWidget {

  final Function? onClose;

  final Order? order;

   CorrectingFingerprintRequest({Key? key,this.onClose,this.order}) : super(key: key){
     if(order != null){
       var fingerPrint = order as FingerprintCorrectionsData;
       dateCtrl.text = fingerPrint.date ?? '';
       fileCtrl.text = fingerPrint.file.split('/').last;
       reasonCtrl.text = fingerPrint.reason;
       controller.attendanceStatus = fingerPrint.workingType;
       controller.correctionTime.value = fingerPrint.time ?? '';
       var endDateArr = fingerPrint.date?.split('-');
       controller.reason = fingerPrint.reason;
       controller.correctionDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);

     }
   }

   final controller = Get.put(FingerPrintController());

  final dateCtrl = TextEditingController();
   final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              MainAppbarWidget(
                'correcting_request',
                onBack: () {
                  Get.back();
                },
              ),
              Expanded(
                  child: SingleChildScrollView(
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
                                    'elements'.tr,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              // DropDownMenu(textHint: 'loan_type'.tr,)

                              const SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime.now());
                                  controller.correctionDate = selectedDate ?? controller.correctionDate;
                                  if(controller.correctionDate != null){
                                    dateCtrl.text = '${controller.correctionDate?.year}-${controller.correctionDate?.month}-${controller.correctionDate?.day} ';
                                  }else{
                                    dateCtrl.text = '';
                                  }
                                },
                                child: TextFormFieldWithIcons(
                                  prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                  hintText: 'date'.tr,
                                  enabled: false,
                                  controller: dateCtrl,
                                ),
                              ),
                              const SizedBox(height: 15,),

                              DropDownWidget(
                                hintText: 'shift'.tr,
                                selectedValue: controller.attendanceStatus?.name ,
                                items:  ['attending'.tr,'leaving'.tr],
                                onSelectedIndex: (int i) {
                                  // controller.holidayType = holidayTypes[i];
                                  controller.attendanceStatus = OrderType(id: i+1,name: ['attending'.tr,'leaving'.tr][i]);
                                },
                                prefixIcon: const SizedBox(
                                    width: 5,
                                    height: 35,
                                    child:
                                    SvgWidget('assets/images/extra_work.svg')),
                              ),

                              // TextFormFieldWithIcons(
                              //   prefixIcon: const SvgWidget('assets/images/extra_work.svg'),
                              //   hintText: 'shift'.tr,
                              //   // height: 130,
                              // ),

                              const SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width:double.infinity,
                                  child: LocalizedText(
                                    'Suggestion_correction_time'.tr,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),

                              // Row(
                              //   children: [
                              //     Checkbox(value: false, onChanged: (value){}),
                              //     // SizedBox(width: 8,),
                              //     Text('confirmed_attend_time'.tr,style: TextStyle(color: AppColors.darkGreyTextColor),),
                              //     Spacer(),
                              //     LocalizedText(
                              //       '8:30',
                              //       textStyle: const TextStyle(
                              //           fontWeight: FontWeight.bold
                              //       ),
                              //     ),
                              //     SizedBox(width: 5,),
                              //     LocalizedText(
                              //       'am'.tr,
                              //       textStyle: const TextStyle(
                              //           fontWeight: FontWeight.bold
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              InkWell(
                                onTap: () async {
                                  var selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 7, minute: 0), );

                                  controller.correctionTime.value = selectedTime != null? '${selectedTime.hour}:${selectedTime.minute}' : controller.correctionTime.value;

                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width:35,
                                          child: Image.asset('assets/images/edit.png')),
                                      SizedBox(width: 8,),
                                      Text('press_to_correct'.tr),
                                      Spacer(),
                                      // Spacer(),
                                      Obx(() => LocalizedText(
                                        controller.timeOfDay,
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      )),
                                      SizedBox(width: 25,)
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  // Checkbox(value: false, onChanged: (value){}),
                                  // // SizedBox(width: 8,),
                                  // Text('confirmed_leaving_time'.tr,style: TextStyle(color: AppColors.darkGreyTextColor),),
                                  // Spacer(),
                                  // Obx(() => LocalizedText(
                                  //   controller.timeOfDay,
                                  //   textStyle: const TextStyle(
                                  //       fontWeight: FontWeight.bold
                                  //   ),
                                  // )),

                                ],
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
                                onChange: (value){
                                  controller.reason = value;
                                },
                                controller: reasonCtrl,
                                prefixIcon: SizedBox(
                                  child: Image.asset('assets/images/conversation.png'),
                                ),
                                maxLines: 5,
                                hintText: 'the_reason'.tr,
                                height: 130,
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
                                  enabled: false,
                                  controller: fileCtrl,
                                  prefixIcon: SizedBox(
                                    child: Image.asset('assets/images/attach.png'),
                                  ),
                                  hintText: 'attach_file'.tr,


                                ),
                              ),
                              const SizedBox(height: 15,),
                              const SizedBox(height: 15,),
                              const SizedBox(height: 15,),
                              order == null
                                  ? InkWell(
                                onTap: _addNewRequest,
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    child: Center(
                                      child: Text(
                                        'send'.tr,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(
                                        8),
                                    gradient:
                                    greenGradiantAppBar,
                                  ),
                                ),
                              )
                                  : SizedBox(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: InkWell(
                                          onTap: _updateRequest,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(
                                                  10.0),
                                              child: Center(
                                                child: Text(
                                                  'update'.tr,
                                                  style: const TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize:
                                                      17),
                                                ),
                                              ),
                                            ),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  8),
                                              gradient:
                                              greenGradiantAppBar,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        child: InkWell(
                                          onTap: _cancelRequest,
                                          child: Container(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(
                                                  10.0),
                                              child: Center(
                                                child: Text(
                                                  'cancel'.tr,
                                                  style: const TextStyle(
                                                      color: Colors
                                                          .white,
                                                      fontSize:
                                                      17),
                                                ),
                                              ),
                                            ),
                                            decoration:
                                            BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  8),
                                              gradient:
                                              redGradiantCancel,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
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
        ),

        controller.loading.value ? Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.3),
          child: const Center(
            child: SendingLoadingWidget(),
          ),
        ):const SizedBox()
      ],
    ));
  }

  _addNewRequest() async{
    try{
      await controller.sendRequest();
      SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      Future.delayed(const Duration(milliseconds: 4600),(){
        Get.back();
      });
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }on StartDateException{
      SnackBars.showErrorSnackBar('error'.tr, 'inter_date_exception'.tr);
    }on ChooseTypeException{
      SnackBars.showErrorSnackBar('error'.tr, 'choose_attend_leave'.tr);
    }on ChooseTimeException{
      SnackBars.showErrorSnackBar('error'.tr, 'ChooseTimeException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'EnterReasonException'.tr);
    }
  }

  _updateRequest() async{
    try{
      println('update holiday request ${order?.orderID}');
      await controller.updateRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      Future.delayed(const Duration(milliseconds: 4600),(){
        Get.back();
      });
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }on StartDateException{
      SnackBars.showErrorSnackBar('error'.tr, 'inter_date_exception'.tr);
    }on ChooseTypeException{
      SnackBars.showErrorSnackBar('error'.tr, 'choose_attend_leave'.tr);
    }on ChooseTimeException{
      SnackBars.showErrorSnackBar('error'.tr, 'ChooseTimeException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'EnterReasonException'.tr);
    }
  }

  _cancelRequest() async {
    controller.loading.value = true;
    try {
      await controller.cancelRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_canceled'.tr);
      Future.delayed(const Duration(milliseconds: 4600), () {
        if (onClose != null) {
          onClose!();
        }
        Get.back();
      });
    } on NoInternetException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    } on NoDataAvailableException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    } finally {
      controller.loading.value = false;
    }
  }
}

