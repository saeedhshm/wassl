import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_appbar.dart';

import '../../../../getx_controllers/orders/overtime_work.dart';
import '../../../../helpers/exceptions/custom_exception.dart';
import '../../../../helpers/exceptions/no_internet.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/over_time.dart';
import '../../../consts_widgets/gradiants.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class ExtraWorkRequest extends StatelessWidget {

  final Function? onClose;
  final Order? order;
   ExtraWorkRequest({Key? key,this.onClose, this.order}) : super(key: key){
     if(order != null) {
       var request = order as OvertimeData;
       dateCtrl.text = request.date ?? '';
       startTimeCtrl.text = (request.startTime ?? '').timeFromTimeSelection;
       endTimeCtrl.text = (request.endTime ?? '').timeFromTimeSelection;
       reasonCtrl.text = request.reason;
       fileCtrl.text = request.file.split('/').last;

       var endDateArr = request.date?.split('-');
       controller.overTimeDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);
       controller.reason = request.reason;
       controller.endTime.value = request.endTime ?? '';
       controller.startTime.value = request.startTime ?? '';
     }
   }

   final controller = Get.put(OverTimeController());

   final dateCtrl = TextEditingController();
   final startTimeCtrl = TextEditingController();
   final endTimeCtrl = TextEditingController();
   final fileCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=> Stack(
        children: [
          Column(
            children: [
              MainAppbarWidget(
                'extra_work_request',
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
                                  var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                  controller.overTimeDate = selectedDate ?? controller.overTimeDate;
                                  if(controller.overTimeDate != null){
                                    dateCtrl.text = '${controller.overTimeDate?.year}-${controller.overTimeDate?.month}-${controller.overTimeDate?.day} ';
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
                              InkWell(
                                onTap: () async {
                                  var selectedTime = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 7, minute: 0), );
                                  controller.startTime.value = selectedTime != null? '${selectedTime.hour}:${selectedTime.minute}' : controller.startTime.value;
                                  if(controller.startTime.value != ''){
                                    startTimeCtrl.text = controller.startTime.value.timeFromTimeSelection;
                                  }else{
                                    startTimeCtrl.text = '';
                                  }
                                },
                                child: TextFormFieldWithIcons(
                                  prefixIcon: const SvgWidget('assets/images/extra_work.svg'),
                                  hintText: 'overtime_starts'.tr,
                                  controller: startTimeCtrl,
                                  enabled: false,
                                  // height: 130,
                                ),
                              ),
                              const SizedBox(height: 15,),
                              InkWell(
                                onTap: () async {
                                  if(controller.startTime.value.isEmpty){
                                    SnackBars.showErrorSnackBar('error'.tr, 'start_time_empty'.tr);
                                  }else{
                                    var selectedTime = await showTimePicker(context: context, initialTime:  TimeOfDay(hour: controller.startTime.value.hourOfTimeSelection , minute: controller.startTime.value.minuteOfTimeSelection ), );
                                    controller.endTime.value = selectedTime != null? '${selectedTime.hour}:${selectedTime.minute}' : controller.endTime.value;
                                    if(controller.endTime.value != ''){
                                      endTimeCtrl.text = controller.endTime.value.timeFromTimeSelection;
                                    }else{
                                      endTimeCtrl.text = '';
                                    }
                                  }
                                },
                                child: TextFormFieldWithIcons(
                                  prefixIcon: const SvgWidget('assets/images/extra_work.svg'),
                                  hintText: 'overtime_ends'.tr,
                                  controller: endTimeCtrl,
                                  enabled: false,
                                  // height: 130,
                                ),
                              ),
                              const SizedBox(height: 15,),

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
                                prefixIcon: SizedBox(
                                  child: Image.asset('assets/images/conversation.png'),
                                ),
                                maxLines: 5,
                                hintText: 'the_reason'.tr,
                                controller: reasonCtrl,
                                height: 130,
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
                                  prefixIcon: SizedBox(
                                    child: Image.asset('assets/images/attach.png'),
                                  ),
                                  hintText: 'attach_file'.tr,
                                  enabled: false,
                                  controller: fileCtrl,

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
          controller.loading.value
              ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: SendingLoadingWidget(),
              ))
              : SizedBox()
        ],
      )),
    );
  }

  _addNewRequest() async {
     try{
       await controller.addNewRequest();
       SnackBars.showConfirmedSnackBar('success'.tr, 'your_request_done'.tr);
       Future.delayed(const Duration(milliseconds: 4600),(){
         Get.back();
       });
     }on NoInternetException catch(e){
       SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

     }on CustomException catch(e){
       SnackBars.showErrorSnackBar('error'.tr, e.errorMessage.tr);

     }finally{
       controller.loading.value = false;
     }
   }
  _updateRequest() async {
    try{
      await controller.updateRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      Future.delayed(const Duration(milliseconds: 4600),(){
        if (onClose != null) {
          onClose!();
        }
        Get.back();
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