import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';

import '../../../../getx_controllers/orders/tabreer_request_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/tabreer.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/dialogs_messages/awsom_dialogs.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/icons/calendar_icon.dart';
import '../../../reusable_widgets/icons/chat_icon.dart';
import '../../../reusable_widgets/icons/letter_icon.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class ApologyRequestPage extends StatelessWidget {

   ApologyRequestPage({super.key, this.onClose, this.order}){
     if (order != null) {
       var request = order as ApologyData;
       controller.reason = request.reason;
       // controller.selectedType = request.type;

       controller.reason = request.reason;
       controller.setDate(request.orderDate);
       reasonCtrl.text = request.reason;
       dateCtrl.text = request.orderDate;

       fileCtrl.text = request.file.split('/').last;
     }
   }

   final Function? onClose;
   final Order? order;

  final reasonCtrl = TextEditingController();
   final fileCtrl = TextEditingController();
   final dateCtrl = TextEditingController();

   final controller = Get.put(ApologyRequestController());

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Obx((){
        if(order != null){
          if(controller
              .orderTypes.value.data != null ){
            for(var type in controller
                .orderTypes.value.data!){
              if(type.id == order?.type?.id){
                controller.selectedType = type;
              }
            }
          }
        }
        return controller.loadingLetterTypes.value
            ? const Center(
          child: SendingLoadingWidget(),
        )
            : Stack(
          children: [
            Column(
              children: [
                MainAppbarWidget(
                  'order_apology',
                  onBack: () {
                    Get.back();
                  },
                ),
                Expanded(
                    child: controller.orderTypes.value.data == null
                        ? Center(
                        child: Text('no_letter_types_loaded'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.darkGreyTextColor)))
                        : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: LocalizedText(
                                      'apology_details'.tr,
                                      textStyle: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                ),
                                // DropDownMenu(textHint: 'loan_type'.tr,)
                                DropDownWidget(
                                  hintText: 'apology_type'.tr,
                                  selectedValue:
                                  controller.selectedType,
                                  items: controller
                                      .orderTypes.value.data!
                                      .map((e) => e)
                                      .toList(),
                                  onSelectedIndex: (value) {
                                    controller.selectedType = value;
                                  },
                                  prefixIcon: const SizedBox(
                                      width: 5,
                                      height: 35,
                                      child: LetterIcon()),
                                ),


                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    var selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100));
                                    controller.date =
                                        selectedDate ?? controller.date;
                                    if (controller.date != null) {
                                      dateCtrl.text =
                                      '${controller.date?.year}-${controller.date?.month}-${controller.date?.day} ';
                                    } else {
                                      dateCtrl.text = '';
                                    }
                                  },

                                  child: TextFormFieldWithIcons(
                                    prefixIcon: const PrefCalendarIcon(),
                                    hintText: 'date'.tr,
                                    controller: dateCtrl,
                                    enabled: false,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: LocalizedText(
                                      'clear_reason'.tr,
                                      textStyle: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                  ),
                                ),
                                TextFormFieldWithIcons(
                                  prefixIcon: const SizedBox(
                                    child: ChatConversationIcon(),
                                  ),
                                  maxLines: 5,
                                  hintText: 'the_reason'.tr,
                                  controller: reasonCtrl,
                                  height: 130,
                                  onChange: (value) {
                                    controller.reason = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    FilePickerResult? result =
                                    await FilePicker.platform
                                        .pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf'],
                                    );

                                    if (result != null) {
                                      String filePath =
                                          result.files.single.path ??
                                              '';

                                      if (filePath.isNotEmpty) {
                                        controller.filePath =
                                            filePath;
                                        fileCtrl.text =
                                            filePath.split('/').last;
                                        // File file = File(filePath);
                                      }
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: TextFormFieldWithIcons(
                                    prefixIcon: const AttachmentIcon(),
                                    hintText: 'attach_file'.tr,
                                    controller: fileCtrl,
                                    enabled: false,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                order == null
                                    ? SendButtonWidget(_addNewRequest)
                                    : CancelUpdateWidget(
                                  onUpdateRequest: _updateRequest,
                                  onCancelRequest: _cancelRequest,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
            controller.loading.value
                ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: SendingLoadingWidget(),
                ))
                : const SizedBox(),
            controller.errorsList.isNotEmpty
                ? ErrorMessageWidget(
                errorList: controller.errorsList,
                onTap: () {
                  ////
                  controller.errorsList.clear();
                })
                : const SizedBox()
          ],
        );
      }),
    );
  }


   _addNewRequest(context) async {
     try {
       await controller.addNewRequest();
       successDialog(context,message: 'your_request_done'.tr,onPress: (){
         if(onClose != null){
           onClose!();
         }
         Get.back();
       }
       );

     } on NoInternetException catch (e) {
       errorDialog(context,message: e.errorMessage.tr);
     } on CustomException catch (e) {
       errorDialog(context,message: e.errorMessage.tr);
     } finally {
       controller.loading.value = false;
     }
   }

   _updateRequest(context) async {
     try {
       await controller.updateRequest('${order?.orderID}');
       successDialog(context,message: 'request_updated'.tr,onPress: (){
         if(onClose != null){
           onClose!();
         }
         Get.back();
       }
       );

     } on NoInternetException catch (e) {
       errorDialog(context,message: e.errorMessage.tr);
     } on CustomException catch (e) {
       errorDialog(context,message: e.errorMessage.tr);
     } finally {
       controller.loading.value = false;
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
       errorDialog(context,message: e.errorMessage.tr);
     } on NoDataAvailableException {
       errorDialog(context,message: 'something_wrong_try_again'.tr);
     } finally {
       controller.loading.value = false;
     }
   }
}
