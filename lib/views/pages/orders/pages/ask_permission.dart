import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/ask_permission.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';

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
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class AskPermissionPage extends StatelessWidget {

  AskPermissionPage({Key? key, this.onClose, this.order}) : super(key: key);

  final AskPermissionController controller = Get.put(AskPermissionController());

  final dateCtrl = TextEditingController();
  final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  final Function? onClose;

  final Order? order;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Obx(() {
        if(order != null){
          var permission = order as AskPermissionsData;
          fileCtrl.text = permission.file.split('/').last;
          reasonCtrl.text = permission.reason;
          controller.reason = permission.reason;
          var endDateArr = permission.date?.split('-');
          dateCtrl.text = permission.date ?? '';


          if(permission.timeIn != null){
            controller.timeInString = permission.timeIn;
          }
          if(permission.timeOut != null){
            controller.timeOutString = permission.timeOut;
          }
          println('=-=-=-=-=-=-==-=');
          controller.permissionDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);

          for(OrderType v in (controller.orderTypes.value.data ?? [])){
            if(v.id == permission.type?.id){
              controller.selectedType = v;
            }
          }
          for(OrderType v in (controller.reasonTypes )){
            if(v.name == permission.reasonType?.name){
              controller.reasonType = v;
            }
          }
        }
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
                                  child: SvgWidget(
                                      'assets/images/extra_work.svg')),
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
                                prefixIcon: const SvgWidget(
                                    'assets/images/pref_calendar_icon.svg'),
                                hintText: 'date'.tr,
                                enabled: false,
                                controller: dateCtrl,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),


                            Row(
                              children: [
                                //var time in var
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );

                                      controller.timeIn = selectedTime;

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                              width:35,
                                              child: Icon(Icons.access_time,color: AppColors.lightGreyTextColor,)),
                                          const SizedBox(width: 8,),

                                          Text('time_in'.tr),

                                          Spacer(),
                                          Obx(() => LocalizedText(
                                            controller.timeIn,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          )),
                                          const SizedBox(width: 25,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                // time out var
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );
                                      controller.timeOut= selectedTime;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                              width:35,
                                              child: Icon(Icons.access_time,color: AppColors.lightGreyTextColor,)),
                                          const SizedBox(width: 8,),
                                          Text('time_out'.tr),

                                          Spacer(),
                                          Obx(() => LocalizedText(
                                            controller.timeOut,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          )),
                                          const SizedBox(width: 25,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                controller.reasonType = value as OrderType?;
                              },
                              prefixIcon: const SizedBox(
                                  width: 5,
                                  height: 35,
                                  child: SvgWidget(
                                      'assets/images/extra_work.svg')),
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
                              prefixIcon: SizedBox(
                                child: Image.asset(
                                    'assets/images/conversation.png'),
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
                                prefixIcon: SizedBox(
                                  child: Image.asset(
                                      'assets/images/attach.png'),
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

  _addNewRequest() async {
    try {
      await controller.addNewPermission();
      SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      Future.delayed(Duration(milliseconds: 4600), () {
        if (onClose != null) {
          onClose!();
        }
        Get.back();
      });
    } on NoInternetException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);
    } on CustomException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);
    } finally {
      controller.loading.value = false;
    }
  }

  _updateRequest() async {
    controller.loading.value = true;
    try {
      await controller.updateRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      Future.delayed(Duration(milliseconds: 4600), () {
        if (onClose != null) {
          onClose!();
        }
        Get.back();
      });
    } on NoInternetException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);
    } on CustomException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);
    } finally {
      controller.loading.value = false;
    }
    ///////////////////


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
