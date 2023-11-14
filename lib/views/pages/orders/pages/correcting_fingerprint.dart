import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/finger_print_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/models/orders/order_type.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/icons/extra_work_icon.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/finger_print.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/dialogs_messages/awsom_dialogs.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/icons/calendar_icon.dart';
import '../../../reusable_widgets/icons/chat_icon.dart';
import '../../../reusable_widgets/icons/edit_icon.dart';
import '../../../reusable_widgets/dialogs_messages/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class CorrectingFingerprintRequest extends StatelessWidget {

  final Function? onClose;

  final Order? order;

  final String? correctionDate;

   CorrectingFingerprintRequest({Key? key,this.onClose,this.order,this.correctionDate}) : super(key: key){
     if(order != null){
       var fingerPrint = order as FingerprintCorrectionsData;
       dateCtrl.text = fingerPrint.date ?? '';
       fileCtrl.text = fingerPrint.file.split('/').last;
       reasonCtrl.text = fingerPrint.reason;
       controller.attendanceStatus = fingerPrint.type;
       controller.correctionTime.value = fingerPrint.time ?? '';
       var endDateArr = fingerPrint.date?.split('-');
       controller.reason = fingerPrint.reason;
       controller.correctionDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);

     }
     if(correctionDate != null){
       dateCtrl.text = '$correctionDate';
       var endDateArr = correctionDate?.split('-');
       controller.correctionDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);
       controller.attendanceStatus = OrderType(id: 2)..name = 'leaving'.tr;
       println('dateCtrl.text =====>>> ${dateCtrl.text}');
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
                    child: Container(
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
                              prefixIcon: const PrefCalendarIcon(),
                              hintText: 'date'.tr,
                              enabled: false,
                              controller: dateCtrl,
                            ),
                          ),
                          const SizedBox(height: 15,),

                          DropDownWidget(
                            hintText: 'shift'.tr,
                            selectedValue: controller.attendanceStatus ,
                            items:  [OrderType(id: 1)..name = 'attending'.tr,OrderType(id: 2)..name = 'leaving'.tr],
                            onSelectedIndex: (value) {
                              // controller.holidayType = holidayTypes[i];
                              controller.attendanceStatus = value as OrderType;
                            },
                            prefixIcon: const SizedBox(
                                width: 5,
                                height: 35,
                                child:ExtraWorkIcon()),
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

                          InkWell(
                            onTap: () async {
                              var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );

                              controller.correctionTime.value = selectedTime != null? '${selectedTime.hour}:${selectedTime.minute}' : controller.correctionTime.value;

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  const SizedBox(
                                      width:35,
                                      child: EditIcon()),
                                  const SizedBox(width: 8,),
                                  Text('press_to_correct'.tr),
                                  Spacer(),
                                  // Spacer(),
                                  Obx(() => LocalizedText(
                                    controller.timeOfDay,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  )),
                                  const SizedBox(width: 25,)
                                ],
                              ),
                            ),
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
                            prefixIcon: const SizedBox(
                              child: ChatConversationIcon(),
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
                              prefixIcon: const AttachmentIcon(),
                              hintText: 'attach_file'.tr,


                            ),
                          ),
                          const SizedBox(height: 15,),
                          const SizedBox(height: 15,),
                          const SizedBox(height: 15,),
                          order == null
                              ? SendButtonWidget(_addNewRequest)
                              : CancelUpdateWidget(
                            onUpdateRequest: _updateRequest,
                            onCancelRequest: _cancelRequest,
                          ),
                          const SizedBox(height: 25,),
                        ],
                      ),
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
        ):const SizedBox(),
        controller.errorsList.isNotEmpty ? ErrorMessageWidget(errorList: controller.errorsList,onTap:(){
          ////
          controller.errorsList.clear();
        }): const SizedBox()
      ],
    ));
  }

  _addNewRequest(context) async{
    try{
      await controller.sendRequest();
      successDialog(context,message: 'your_request_done'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );

    }on NoInternetException catch(e){
      errorDialog(context,message: e.errorMessage);
    }on NoDataAvailableException catch(e){
      errorDialog(context,message: 'something_wrong_try_again'.tr);
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

  _updateRequest(context) async{
    try{
      await controller.updateRequest('${order?.orderID}');
      successDialog(context,message: 'request_updated'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );

    }on NoInternetException catch(e){
      errorDialog(context,message: e.errorMessage);
    }on NoDataAvailableException catch(e){
      errorDialog(context,message: 'something_wrong_try_again'.tr);
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

  _cancelRequest(context) async {
    controller.loading.value = true;
    try {
      await controller.cancelRequest('${order?.orderID}');
      successDialog(context,message: 'request_canceled'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );

    } on NoInternetException catch (e) {
      errorDialog(context,message: e.errorMessage);
    } on NoDataAvailableException catch (e) {
      errorDialog(context,message: 'something_wrong_try_again'.tr);
    } finally {
      controller.loading.value = false;
    }
  }
}

