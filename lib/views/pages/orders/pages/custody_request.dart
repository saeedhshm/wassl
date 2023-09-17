import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/orders/custoday_controller.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/icons/chat_icon.dart';
import 'package:wassl/views/reusable_widgets/icons/person_in_lock.dart';

import '../../../../helpers/constants/print_ln.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/custoday.dart';
import '../../../../models/orders/order_type.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class CustodyRequestPage extends StatelessWidget {

  final Function? onClose;
  final Order? order;

   CustodyRequestPage({Key? key,this.onClose, this.order}) : super(key: key){
     if(order != null) {
       var custodyDate = order as CustodyDate;
       controller.selectedType = custodyDate.type;
       controller.reason = custodyDate.reason;
       reasonCtrl.text = custodyDate.reason;
       fileCtrl.text = custodyDate.file.split('/').last;
     }

   }
   final CustodyRequestController controller = Get.put(CustodyRequestController());
   final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Stack(
        children: [
          Column(
            children: [
              MainAppbarWidget(
                'order_custody',
                onBack: () {
                  Get.back();
                },
              ),
              Expanded(
                  child: controller.loadingTypes.value ?
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
                                    'custody_details'.tr,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              // DropDownMenu(textHint: 'loan_type'.tr,)
                              DropDownWidget(
                                hintText: 'custody_type'.tr,
                                items:  controller.orderTypes.value.data!.map((e) => e).toList(),
                                selectedValue: controller.selectedType,
                                onSelectedIndex: (value) {
                                  controller.selectedType = value as OrderType?;
                                },
                                prefixIcon: const SizedBox(
                                    width: 5,
                                    height: 35,
                                    child: PersonInLockIcon()),
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
                                prefixIcon: const SizedBox(
                                  child: ChatConversationIcon(),
                                ),
                                maxLines: 5,
                                hintText: 'the_reason'.tr,
                                height: 130,
                                controller: reasonCtrl,
                                onChange: (value){
                                  controller.reason = value;
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
                                  prefixIcon: const AttachmentIcon(),
                                  hintText: 'attach_file'.tr,

                                  enabled: false,
                                  controller: fileCtrl,
                                ),
                              ),
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
          controller.errorsList.isNotEmpty ? ErrorMessageWidget(errorList: controller.errorsList,onTap:(){
            ////
            controller.errorsList.clear();
          }): const SizedBox()
        ],
      )),
    );
  }

  _addNewRequest()async{
    try{
      await controller.addNewPermission();
      Get.back();
      Future.delayed(Duration(milliseconds: 0),(){

        SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
      });
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

    }on CustomException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

    }finally{
      controller.loading.value = false;
    }
  }

  _updateRequest()async{
    try{
      await controller.updateRequest('${order?.orderID}');
      Get.back();
      Future.delayed(Duration.zero,(){
        SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      });

    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

    }on CustomException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

    }finally{
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
