import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/ask_permission.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/icons/calendar_icon.dart';
import 'package:wassl/views/reusable_widgets/icons/extra_work_icon.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/ask_permission.dart';
import '../../../../models/orders/order_type.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/dialogs_messages/awsom_dialogs.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/icons/chat_icon.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/dialogs_messages/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class AskPermissionPage extends StatelessWidget {

  AskPermissionPage({Key? key, this.onClose, this.order}) : super(key: key){
    if(order != null){
      var permission = order as AskPermissionsData;
      fileCtrl.text = permission.file.split('/').last;
      reasonCtrl.text = permission.reason;
      controller.reason = permission.reason;
      var endDateArr = permission.date?.split('-');
      dateCtrl.text = permission.date ?? '';


      if(permission.timeIn != null){
        controller.timeInString = permission.timeIn;
        startTimeCtrl.text = controller.timeIn;
      }
      if(permission.timeOut != null){
        controller.timeOutString = permission.timeOut;
        endTimeCtrl.text = controller.timeOut;
      }

      controller.permissionDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);
      controller.selectedType = permission.type;
      controller.reasonType = permission.reasonType;
      // for(OrderType v in (controller.orderTypes.value.data ?? [])){
      //   if(v.id == permission.type?.id){
      //     controller.selectedType = v;
      //   }
      // }
      // for(OrderType v in (controller.reasonTypes )){
      //   if(v.name == permission.reasonType?.name){
      //     controller.reasonType = v;
      //   }
      // }
    }
  }

  final AskPermissionController controller = Get.put(AskPermissionController());

  final dateCtrl = TextEditingController();
  final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();
  final startTimeCtrl = TextEditingController();
  final endTimeCtrl = TextEditingController();

  final Function? onClose;

  final Order? order;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Obx(() {

        return Stack(
          children: [
            Column(
              children: [
                MainAppbarWidget(
                  'ask_permission',
                  onBack: () {
                    Get.back();
                  },
                ),
                Expanded(
                    child: controller.loadingTypes.value
                        ? const Center(
                      child: SendingLoadingWidget(),
                    )
                        : SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            // header
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: LocalizedText(
                                  'elements'.tr,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // DropDownMenu(textHint: 'loan_type'.tr,)

                            const SizedBox(
                              height: 15,
                            ),

                            // permission types
                            DropDownWidget(
                              hintText: 'permission_type'.tr,
                              selectedValue: controller.selectedType,
                              items: controller
                                  .orderTypes.value.data!
                                  .map((e) => e)
                                  .toList(),
                              onSelectedIndex: (value) {
                                controller.selectedType = value as OrderType?;
                              },
                              prefixIcon: const SizedBox(
                                  width: 5,
                                  height: 35,
                                  child: ExtraWorkIcon()),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            // Date
                            InkWell(
                              onTap: () async {
                                var selectedDate =
                                await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100));
                                controller.permissionDate =
                                    selectedDate ??
                                        controller.permissionDate;
                                if (controller.permissionDate !=
                                    null) {
                                  dateCtrl.text =
                                  '${controller.permissionDate?.year}-${controller.permissionDate?.month}-${controller.permissionDate?.day} ';
                                } else {
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
                            const SizedBox(
                              height: 15,
                            ),

                            InkWell(
                              onTap: () async {
                                var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );

                                controller.timeIn = selectedTime;
                                startTimeCtrl.text = controller.timeIn;

                              },
                              child: TextFormFieldWithIcons(
                                prefixIcon: const ExtraWorkIcon(),
                                hintText: 'time_in'.tr,
                                controller: startTimeCtrl,
                                enabled: false,
                                // height: 130,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                if (controller.timeIn.isEmpty) {
                                  SnackBars.showErrorSnackBar(
                                      'error'.tr, 'start_time_empty'.tr);
                                } else {
                                  var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );
                                  controller.timeOut = selectedTime;
                                  endTimeCtrl.text = controller.timeOut;
                                }
                              },
                              child: TextFormFieldWithIcons(
                                prefixIcon: const ExtraWorkIcon(),
                                hintText: 'time_out'.tr,
                                controller: endTimeCtrl,
                                enabled: false,
                                // height: 130,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // reasons types
                            DropDownWidget(
                              hintText: 'reason_type'.tr,
                              selectedValue: controller.reasonType,
                              items:controller
                                  .reasonTypes
                                  .map((e) => e).toList() ,
                              onSelectedIndex: (value) {
                                controller.reasonType = value ;
                              },
                              prefixIcon: const SizedBox(
                                  width: 5,
                                  height: 35,
                                  child:  ExtraWorkIcon()),
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
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TextFormFieldWithIcons(
                              prefixIcon: const SizedBox(
                                child: ChatConversationIcon(),
                              ),
                              maxLines: 5,
                              hintText: 'the_reason'.tr,
                              height: 130,
                              controller: reasonCtrl,
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
                                    controller.filePath = filePath;
                                    fileCtrl.text =
                                        filePath.split('/').last;
                                    // File file = File(filePath);
                                  }
                                } else {
                                  // User canceled the picker
                                }
                              },
                              child: TextFormFieldWithIcons(
                                prefixIcon: const SizedBox(
                                  child: AttachmentIcon(),
                                ),
                                hintText: 'attach_file'.tr,
                                enabled: false,
                                controller: fileCtrl,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const SizedBox(
                              height: 15,
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
                : SizedBox(),
            controller.errorsList.isNotEmpty ? ErrorMessageWidget(errorList: controller.errorsList,onTap:(){
              ////
              controller.errorsList.clear();
            }): const SizedBox()
          ],
        );
      }),
    );
  }

  _addNewRequest(context) async {
    try {
      await controller.addNewPermission();
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
    controller.loading.value = true;
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
    ///////////////////


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
    } on NoDataAvailableException catch (e) {
      errorDialog(context,message: 'something_wrong_try_again'.tr);
    } finally {
      controller.loading.value = false;
    }
  }
}
