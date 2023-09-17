import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/icons/chat_icon.dart';
import 'package:wassl/views/reusable_widgets/icons/money_on_hand.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../../../getx_controllers/orders/financial_expenses.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/financial_expenses.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/icons/calendar_icon.dart';
import '../../../reusable_widgets/icons/dollar_on_hand.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class FinanceSpendedRequest extends StatelessWidget {
  final Function? onClose;
  final Order? order;

  FinanceSpendedRequest({Key? key, this.onClose, this.order})
      : super(key: key) {
    if (order != null) {
      var custodyDate = order as FinancialExpensesDate;
      controller.reason = custodyDate.reason;
      controller.title = custodyDate.name;
      titleCtrl.text = custodyDate.name ?? '';
      amountCtrl.text = '${custodyDate.amount}';
      controller.amount = '${custodyDate.amount}';
      descriptionCtrl.text = '${custodyDate.description}';
      controller.description = '${custodyDate.description}';
      reasonCtrl.text = custodyDate.reason;
      fileCtrl.text = custodyDate.file.split('/').last;
      var endDateArr = custodyDate.date?.split('-');
      dateCtrl.text = custodyDate.date ?? '';
      controller.date = DateTime(
        int.tryParse(endDateArr?[0] ?? '') ?? 0,
        int.tryParse(endDateArr?[1] ?? '') ?? 0,
        int.tryParse(endDateArr?[2] ?? '') ?? 0,
      );
    }
  }

  final FinanceSpendedRequestController controller =
      Get.put(FinanceSpendedRequestController());

  final dateCtrl = TextEditingController();
  final fileCtrl = TextEditingController();
  final titleCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  MainAppbarWidget(
                    'order_Financialـcompensation',
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
                                  width: double.infinity,
                                  child: LocalizedText(
                                    'elements'.tr,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // DropDownMenu(textHint: 'loan_type'.tr,)
                              // DropDownWidget(
                              //   hintText: 'element_type'.tr,
                              //   items: const ['done', 'not done'],
                              //   onSelectedIndex: (int i) {},
                              //   prefixIcon: const SizedBox(
                              //       width: 5,
                              //       height: 35,
                              //       child:
                              //       SvgWidget('assets/images/loan_type.svg')),
                              // ),
                              TextFormFieldWithIcons(
                                prefixIcon: const DollarOnHandIcon(),
                                onChange: (value) {
                                  controller.title = value;
                                },
                                hintText: 'title'.tr,
                                controller: titleCtrl,
                                // suffixIcon: const SizedBox(
                                //   width: 25,
                                //   child: Center(
                                //     child: Text('ر.س',style: TextStyle(
                                //         color: Colors.grey
                                //     ),),
                                //   ),
                                // ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormFieldWithIcons(
                                prefixIcon: const MoneyOnHandIcon(),
                                hintText: 'value'.tr,
                                controller: amountCtrl,
                                onChange: (value) {
                                  controller.amount = value;
                                },
                                suffixIcon:  SizedBox(
                                  width: 25,
                                  child: Center(
                                    child: Text(
                                      'SAR'.tr,
                                      style: const TextStyle(color: AppColors.iconsColor,fontSize: 12),
                                    ),
                                  ),
                                ),
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
                              TextFormFieldWithIcons(
                                prefixIcon: const ChatConversationIcon(),
                                hintText: 'description'.tr,
                                controller: descriptionCtrl,
                                onChange: (value) {
                                  controller.description = value;
                                },
                                // height: 130,
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
                                controller: reasonCtrl,
                                hintText: 'reason'.tr,
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
                                      await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf'],
                                  );

                                  if (result != null) {
                                    String filePath =
                                        result.files.single.path ?? '';

                                    if (filePath.isNotEmpty) {
                                      controller.filePath = filePath;
                                      fileCtrl.text = filePath.split('/').last;
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
                  : SizedBox(),
              controller.errorsList.isNotEmpty
                  ? ErrorMessageWidget(
                      errorList: controller.errorsList,
                      onTap: () {
                        ////
                        controller.errorsList.clear();
                      })
                  : const SizedBox()
            ],
          )),
    );
  }

  _addNewRequest() async {
    try {
      await controller.addNewRequest();
      SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      Future.delayed(const Duration(milliseconds: 4600), () {
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
    try {
      await controller.updateRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      Future.delayed(const Duration(milliseconds: 4600), () {
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
