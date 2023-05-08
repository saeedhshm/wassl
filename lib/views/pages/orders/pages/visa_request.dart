import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/visa_request.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/visa_order.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class VisaRequestPage extends StatelessWidget {
  final Function? onClose;
  final Order? order;

  VisaRequestPage({Key? key, this.onClose, this.order}) : super(key: key) {
    if (order != null) {
      var request = order as OrderVisaData;
      fileCtrl.text = request.file.split('/').last;
      reasonCtrl.text = request.reason;
      dateBeforeCtrl.text = request.requiredBefore ?? '';
      goDateCtrl.text = request.goDate ?? '';
      backDateCtrl.text = request.backDate ?? '';

      controller.selectedType = request.type;
      controller.selectedTime = request.orderVisaTime;
      controller.selectedTicketType = request.orderVisaTicketType;
      controller.reason = request.reason;
      controller.haveTicket.value = request.hasTicket;
      controller.goAndBackTicket.value = request.hasBackTicket;

      var beforeDateArr = request.requiredBefore?.split('-');
      controller.dateBefore = DateTime(
        int.tryParse(beforeDateArr?[0] ?? '') ?? 0,
        int.tryParse(beforeDateArr?[1] ?? '') ?? 0,
        int.tryParse(beforeDateArr?[2] ?? '') ?? 0,
      );

      var goDateArr = request.goDate?.split('-');
      controller.goDate = DateTime(
        int.tryParse(goDateArr?[0] ?? '') ?? 0,
        int.tryParse(goDateArr?[1] ?? '') ?? 0,
        int.tryParse(goDateArr?[2] ?? '') ?? 0,
      );

      var backDateArr = request.backDate?.split('-');
      controller.backDate = DateTime(
        int.tryParse(backDateArr?[0] ?? '') ?? 0,
        int.tryParse(backDateArr?[1] ?? '') ?? 0,
        int.tryParse(backDateArr?[2] ?? '') ?? 0,
      );
    }
  }

  final controller = Get.put(VisaRequestController());

  final dateBeforeCtrl = TextEditingController();
  final goDateCtrl = TextEditingController();
  final backDateCtrl = TextEditingController();

  final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  MainAppbarWidget(
                    'request_visa',
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    DropDownWidget(
                                      hintText: 'visa_type'.tr,
                                      selectedValue:
                                          controller.selectedType?.name,
                                      items: controller.visaTypes.value.data
                                              ?.map((e) => e.name ?? '')
                                              .toList() ??
                                          [],
                                      onSelectedIndex: (int i) {
                                        controller.selectedType =
                                            controller.visaTypes.value.data?[i];
                                        println(
                                            '${controller.selectedType?.id}');
                                        println(
                                            '${controller.selectedType?.name}');
                                      },
                                      prefixIcon: const SizedBox(
                                          width: 5,
                                          height: 35,
                                          child: SvgWidget(
                                              'assets/images/extra_work.svg')),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    DropDownWidget(
                                      hintText: 'visa_time'.tr,
                                      selectedValue:
                                          controller.selectedTime?.name,
                                      items: controller.visaTimes.value.data
                                              ?.map((e) => e.name ?? '')
                                              .toList() ??
                                          [],
                                      onSelectedIndex: (int i) {
                                        controller.selectedTime =
                                            controller.visaTimes.value.data?[i];
                                        println(
                                            '${controller.selectedTime?.id}');
                                        println(
                                            '${controller.selectedTime?.name}');
                                      },
                                      prefixIcon: const SizedBox(
                                          width: 5,
                                          height: 35,
                                          child: SvgWidget(
                                              'assets/images/extra_work.svg')),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var selectedDate = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100));
                                        controller.dateBefore = selectedDate ??
                                            controller.dateBefore;
                                        if (controller.dateBefore != null) {
                                          dateBeforeCtrl.text =
                                              '${controller.dateBefore?.year}-${controller.dateBefore?.month}-${controller.dateBefore?.day} ';
                                        } else {
                                          dateBeforeCtrl.text = '';
                                        }
                                      },
                                      child: TextFormFieldWithIcons(
                                        prefixIcon: const SvgWidget(
                                            'assets/images/pref_calendar_icon.svg'),
                                        hintText: 'date_before'.tr,
                                        enabled: false,
                                        controller: dateBeforeCtrl,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              LocalizedText(
                                                'traviling_ticket'.tr,
                                                textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Spacer(),
                                              Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Switch(
                                                    value: controller
                                                        .haveTicket.value,
                                                    onChanged: (value) {
                                                      controller.haveTicket
                                                          .value = value;
                                                      if (!value) {
                                                        controller
                                                            .goAndBackTicket
                                                            .value = false;
                                                      }
                                                    },
                                                    activeColor: AppColors
                                                        .mainGreenColor,
                                                  ))
                                            ],
                                          ),
                                          !controller.haveTicket.value
                                              ? SizedBox()
                                              : Container(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  width: double.infinity,
                                                  height: 0.5,
                                                ),
                                          !controller.haveTicket.value
                                              ? SizedBox()
                                              : Row(
                                                  children: [
                                                    LocalizedText(
                                                      'go_return'.tr,
                                                      textStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    Spacer(),
                                                    Directionality(
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        child: Switch(
                                                          value: controller
                                                              .goAndBackTicket
                                                              .value,
                                                          onChanged: (value) {
                                                            controller
                                                                .goAndBackTicket
                                                                .value = value;
                                                          },
                                                          activeColor: AppColors
                                                              .mainGreenColor,
                                                        ))
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                    !controller.haveTicket.value
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              DropDownWidget(
                                                hintText: 'ticket_type'.tr,
                                                selectedValue: controller
                                                    .selectedTicketType?.name,
                                                items: controller
                                                        .ticketTypes.value.data
                                                        ?.map(
                                                            (e) => e.name ?? '')
                                                        .toList() ??
                                                    [],
                                                onSelectedIndex: (int i) {
                                                  controller
                                                          .selectedTicketType =
                                                      controller.ticketTypes
                                                          .value.data?[i];
                                                  println(
                                                      '${controller.selectedTicketType?.id}');
                                                  println(
                                                      '${controller.selectedTicketType?.name}');
                                                },
                                                prefixIcon: const SizedBox(
                                                    width: 5,
                                                    height: 35,
                                                    child: SvgWidget(
                                                        'assets/images/extra_work.svg')),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  var selectedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(2100));
                                                  controller.goDate =
                                                      selectedDate ??
                                                          controller.goDate;
                                                  if (controller.goDate !=
                                                      null) {
                                                    goDateCtrl.text =
                                                        '${controller.goDate?.year}-${controller.goDate?.month}-${controller.goDate?.day} ';
                                                  } else {
                                                    goDateCtrl.text = '';
                                                  }
                                                },
                                                child: TextFormFieldWithIcons(
                                                  prefixIcon: const SvgWidget(
                                                      'assets/images/pref_calendar_icon.svg'),
                                                  hintText: 'go_date'.tr,
                                                  enabled: false,
                                                  controller: goDateCtrl,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              !controller.goAndBackTicket.value
                                                  ? SizedBox()
                                                  : InkWell(
                                                      onTap: () async {
                                                        var selectedDate =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    DateTime(
                                                                        2000),
                                                                lastDate:
                                                                    DateTime(
                                                                        2100));
                                                        controller.backDate =
                                                            selectedDate ??
                                                                controller
                                                                    .backDate;
                                                        if (controller
                                                                .backDate !=
                                                            null) {
                                                          backDateCtrl.text =
                                                              '${controller.backDate?.year}-${controller.backDate?.month}-${controller.backDate?.day} ';
                                                        } else {
                                                          backDateCtrl.text =
                                                              '';
                                                        }
                                                      },
                                                      child:
                                                          TextFormFieldWithIcons(
                                                        prefixIcon: const SvgWidget(
                                                            'assets/images/pref_calendar_icon.svg'),
                                                        hintText:
                                                            'back_date'.tr,
                                                        enabled: false,
                                                        controller:
                                                            backDateCtrl,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                            ],
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
                                      height: 8,
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
                                        ? SendButtonWidget(_sendData)
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
                            )),
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

  _sendData() async {
    try {
      await controller.addNewRequest();
      SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      Future.delayed(Duration(milliseconds: 4600), () {
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
