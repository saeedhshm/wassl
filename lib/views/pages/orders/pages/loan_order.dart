import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:wassl/getx_controllers/orders/loan_order_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/exceptions/custom_exception.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/loan_order.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class NewLoanOrder extends StatelessWidget {
  final Function? onClose;
  final Order? order;

  NewLoanOrder({Key? key, this.onClose, this.order}) : super(key: key) {
    if (order != null) {
      var request = order as LoansData;
      dateCtrl.text = request.orderDate;
      fileCtrl.text = request.file.split('/').last;
      amountCtrl.text = '${request.amount}';
      monthlyAmountCtrl.text = '${request.installmentAmount}';
      monthlyMehtodCtrl.text = request.monthlyInstallment ?? '';
      reasonCtrl.text = request.reason;

      var endDateArr = request.month?.split('-');
      controller.loanStartingDate = DateTime(
        int.tryParse(endDateArr?[0] ?? '') ?? 0,
        int.tryParse(endDateArr?[1] ?? '') ?? 0,
        int.tryParse(endDateArr?[2] ?? '') ?? 0,
      );
      controller.amount = amountCtrl.text;
      controller.reason = reasonCtrl.text;
      controller.installmentMonthlyAmount = monthlyAmountCtrl.text;
      controller.monthlyInstallmentMethod = monthlyMehtodCtrl.text;
      controller.selectedType = request.type;
    }
  }

  final LoanOrderController controller = Get.put(LoanOrderController());

  final dateCtrl = TextEditingController();
  final fileCtrl = TextEditingController();

  final amountCtrl = TextEditingController();
  final monthlyAmountCtrl = TextEditingController();
  final monthlyMehtodCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // controller.loading.value = false;
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  MainAppbarWidget(
                    'order_laon',
                    onBack: () {
                      Get.back();
                    },
                  ),
                  Obx(() => Expanded(
                      child: controller.loadingLoansTypes.value
                          ? const Center(
                              child: SendingLoadingWidget(),
                            )
                          : SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: LocalizedText(
                                          'loan_details'.tr,
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // DropDownMenu(textHint: 'loan_type'.tr,)
                                    DropDownWidget(
                                      hintText: 'loan_type'.tr,
                                      selectedValue:
                                          controller.selectedType?.name,
                                      items: controller.orderTypes.value.data!
                                          .map((e) => e.name ?? '')
                                          .toList(),
                                      onSelectedIndex: (int i) {
                                        controller.selectedType = controller
                                            .orderTypes.value.data![i];
                                      },
                                      prefixIcon: const SizedBox(
                                          width: 5,
                                          height: 35,
                                          child: SvgWidget(
                                              'assets/images/loan_type.svg')),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormFieldWithIcons(
                                      prefixIcon: const SvgWidget(
                                          'assets/images/money_on_hand.svg'),
                                      hintText: 'value'.tr,
                                      controller: amountCtrl,
                                      keyboardType: TextInputType.number,
                                      onChange: (value) {
                                        controller.amount = value;
                                      },
                                      suffixIcon:  SizedBox(
                                        width: 25,
                                        child: Center(
                                          child: Text(
                                            'SAR'.tr,
                                            style:
                                                TextStyle(color: Colors.grey,fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var selectedDate =
                                            await showMonthYearPicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100));
                                        controller.loanStartingDate =
                                            selectedDate ??
                                                controller.loanStartingDate;
                                        if (controller.loanStartingDate !=
                                            null) {
                                          dateCtrl.text =
                                              '${controller.loanStartingDate?.year}-${controller.loanStartingDate?.month}-${controller.loanStartingDate?.day} ';
                                        } else {
                                          dateCtrl.text = '';
                                        }
                                      },
                                      child: TextFormFieldWithIcons(
                                        prefixIcon: const SvgWidget(
                                            'assets/images/pref_calendar_icon.svg'),
                                        hintText: 'start_cutting_amount'.tr,
                                        enabled: false,
                                        controller: dateCtrl,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormFieldWithIcons(
                                      prefixIcon: const SvgWidget(
                                          'assets/images/money_on_hand.svg'),
                                      hintText: 'installmentMonthlyAmount'.tr,
                                      controller: monthlyAmountCtrl,
                                      keyboardType: TextInputType.number,
                                      onChange: (value) {
                                        controller.installmentMonthlyAmount =
                                            value;
                                      },
                                      suffixIcon:  SizedBox(
                                        width: 25,
                                        child: Center(
                                          child: Text(
                                            'SAR'.tr,
                                            style:
                                                TextStyle(color: Colors.grey,fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: LocalizedText(
                                          'calculate_loan_installment_way'.tr,
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    TextFormFieldWithIcons(
                                      prefixIcon: const SvgWidget(
                                          'assets/images/pref_calendar_icon.svg'),
                                      hintText: 'monthly_installment_method'.tr,
                                      controller: monthlyMehtodCtrl,
                                      // keyboardType: TextInputType.number,
                                      onChange: (value) {
                                        controller.monthlyInstallmentMethod =
                                            value;
                                      },
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
                                      controller: reasonCtrl,
                                      prefixIcon: SizedBox(
                                        child: Image.asset(
                                            'assets/images/conversation.png'),
                                      ),
                                      maxLines: 5,
                                      hintText: 'the_reason'.tr,
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
                                            fileCtrl.text =
                                                filePath.split('/').last;
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
                                          child: Image.asset(
                                              'assets/images/attach.png'),
                                        ),
                                        hintText: 'attach_file'.tr,
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
                              ),
                            )))
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
          )),
    );
  }

  _addNewRequest() async {
    try {
      await controller.addNewLoad();
      SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      Future.delayed(Duration(milliseconds: 4600), () {
        Get.back();
      });
      // Get.back();
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
