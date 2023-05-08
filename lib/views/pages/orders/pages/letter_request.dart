import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/letter_request.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';

import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/letter.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class LetterRequestPage extends StatelessWidget {
  final Function? onClose;
  final Order? order;

  LetterRequestPage({Key? key, this.onClose, this.order}) : super(key: key) {
    if (order != null) {
      var request = order as LetterDate;
      controller.reason = request.reason;
      controller.selectedType = request.type;
      controller.directedToAr = request.directedToAr;
      controller.directedToEn = request.directedToEn;
      controller.reason = request.reason;

      directedToArCtrl.text = request.directedToAr ?? '';
      directedToEnCtrl.text = request.directedToEn ?? '';
      reasonCtrl.text = request.reason ?? '';
    }
  }

  final controller = Get.put(LetterRequestController());

  final fileCtrl = TextEditingController();
  final directedToArCtrl = TextEditingController();
  final directedToEnCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.loadingLetterTypes.value
          ? const Center(
              child: SendingLoadingWidget(),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    MainAppbarWidget(
                      'order_letter',
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
                                                'letter_details'.tr,
                                                textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          // DropDownMenu(textHint: 'loan_type'.tr,)
                                          DropDownWidget(
                                            hintText: 'letter_type'.tr,
                                            selectedValue:
                                                controller.selectedType?.name,
                                            items: controller
                                                .orderTypes.value.data!
                                                .map((e) => e.name ?? '')
                                                .toList(),
                                            onSelectedIndex: (int i) {
                                              controller.selectedType =
                                                  controller.orderTypes.value
                                                      .data![i];
                                            },
                                            prefixIcon: const SizedBox(
                                                width: 5,
                                                height: 35,
                                                child: SvgWidget(
                                                    'assets/images/letter.svg')),
                                          ),

                                          // const SizedBox(height: 15,),
                                          // TextFormFieldWithIcons(
                                          //   prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                          //   hintText: 'date'.tr,
                                          //
                                          //
                                          // ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextFormFieldWithIcons(
                                            prefixIcon: const SvgWidget(
                                                'assets/images/letter.svg'),
                                            hintText: 'foreword_to_ar'.tr,
                                            controller: directedToArCtrl,
                                            onChange: (value) {
                                              controller.directedToAr = value;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextFormFieldWithIcons(
                                            prefixIcon: const SvgWidget(
                                                'assets/images/letter.svg'),
                                            hintText: 'foreword_to_en'.tr,
                                            controller: directedToEnCtrl,
                                            onChange: (value) {
                                              controller.directedToEn = value;
                                            },
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
                                            prefixIcon: SizedBox(
                                              child: Image.asset(
                                                  'assets/images/conversation.png'),
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
                                              prefixIcon: SizedBox(
                                                child: Image.asset(
                                                    'assets/images/attach.png'),
                                              ),
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
            )),
    );
  }

  _addNewRequest() async {
    try {
      await controller.addNewLetter();
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
