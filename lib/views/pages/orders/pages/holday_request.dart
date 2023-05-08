import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/holiday/holiday_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/orders/holiday.dart';
// import 'package:wassl/models/orders/holday/holiday_type.dart';
import 'package:wassl/views/consts_widgets/gradiants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/snack_bars.dart';

import '../../../../getx_controllers/orders/previous_requests.dart';
import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class HolidayRequestPage extends StatelessWidget {

  final controller = Get.put(HolidayController());
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();
  final fileCtrl = TextEditingController();

  final Function? onClose;

  final Order? order;

   HolidayRequestPage({Key? key,this.onClose,this.order}) : super(key: key){
     if(order != null){
       var holidayOrder = order as HolidaysData;
       startDateCtrl.text = holidayOrder.holidayStart ?? '';
       endDateCtrl.text = holidayOrder.holidayEnd ?? '';
       controller.selectedType = holidayOrder.type;
       reasonCtrl.text = holidayOrder.reason;
       fileCtrl.text = holidayOrder.file.split('/').last;
       var startDateArr = holidayOrder.holidayStart?.split('-');
       var endDateArr = holidayOrder.holidayEnd?.split('-');
       controller.startDate = DateTime(int.tryParse(startDateArr?[0] ?? '') ?? 0,int.tryParse(startDateArr?[1] ?? '') ?? 0,int.tryParse(startDateArr?[2] ?? '') ?? 0,);
       controller.endDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);

       controller.holidayReason = holidayOrder.reason;
       controller.filePath = holidayOrder.file == '' ? null : holidayOrder.file;
       println(controller.startDate);
       println(controller.endDate);
       controller.setDifferenceInDays();
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Stack(
        children: [
          Column(
            children: [
              MainAppbarWidget(
                'order_holiday',
                onBack: () {
                  Get.back();
                },
              ),
              Expanded(
                  child:controller.loadingHolidayTypes.value ?
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
                                    'holiday_details'.tr,
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              // DropDownMenu(textHint: 'loan_type'.tr,)
                              DropDownWidget(
                                hintText: 'holiday_type'.tr,
                                selectedValue: controller.selectedType?.name,
                                items:  controller.orderTypes.value.data!.map((e) => e.name ?? '').toList(),
                                onSelectedIndex: (int i) {
                                  controller.selectedType = controller.orderTypes.value.data![i];
                                },
                                prefixIcon: const SizedBox(
                                    width: 5,
                                    height: 35,
                                    child:
                                    SvgWidget('assets/images/holidays.svg')),
                              ),
                              const SizedBox(height: 15,),

                              Row(
                                children: [
                                  Expanded(child: InkWell(
                                    onTap: () async {
                                      var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                      controller.startDate = selectedDate ?? controller.startDate;
                                      if(controller.startDate != null){
                                        startDateCtrl.text = '${controller.startDate?.year}-${controller.startDate?.month}-${controller.startDate?.day} ';
                                      }else{
                                        startDateCtrl.text = '';
                                      }
                                    },
                                    child:TextFormFieldWithIcons(
                                      prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                      hintText: 'start'.tr,
                                      enabled: false,
                                      controller: startDateCtrl,
                                    ),

                                  ),),
                                  SizedBox(width: 16,),
                                  Expanded(child: InkWell(
                                    onTap: () async {
                                      if(controller.startDate != null){
                                        var selectedDate = await showDatePicker(context: context, initialDate: controller.startDate ?? DateTime.now(), firstDate: controller.startDate ?? DateTime(2000), lastDate: DateTime(2100));
                                        controller.endDate = selectedDate ?? controller.endDate;
                                        if(controller.endDate != null){
                                          endDateCtrl.text = '${controller.endDate?.year}-${controller.endDate?.month}-${controller.endDate?.day} ';
                                          controller.setDifferenceInDays();
                                        }else{
                                          endDateCtrl.text = '';
                                        }
                                      }else{
                                        controller.differenceInDays.value = '';
                                        SnackBars.showErrorSnackBar('error'.tr, 'select_start_date_first'.tr);
                                      }
                                    },
                                    child: TextFormFieldWithIcons(
                                      prefixIcon: const SvgWidget('assets/images/pref_calendar_icon.svg'),
                                      hintText: 'end'.tr,
                                      enabled: false,
                                      controller: endDateCtrl,

                                    ),
                                  ),)
                                ],
                              ),
                              controller.differenceInDays.value.isNotEmpty ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.darkGreyTextColor,width: 0.5),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2),
                                        child: Row(
                                          children: [

                                            SizedBox(
                                              width: 20,
                                              child: Image.asset('assets/images/order_details/calendar.png'),
                                            ),
                                            const SizedBox(width: 8,),
                                            Text('holiday_time'.tr,style: const TextStyle(
                                                color: AppColors.darkGreyTextColor,
                                                // fontWeight: FontWeight.bold
                                            ),),
                                            SizedBox(width: 16,),
                                            SizedBox(
                                              width: 25,
                                              child: Image.asset('assets/images/order_details/arrow.png'),
                                            ),
                                            SizedBox(width: 16,),
                                            Text(controller.differenceInDays.value,style: const TextStyle(
                                                color: AppColors.darkGreyTextColor,
                                                // fontSize: 12
                                            ),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : SizedBox(),
                              const SizedBox(height: 10,),



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
                                height: 130,
                                controller: reasonCtrl,
                                onChange: (value){
                                  controller.holidayReason = value;
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
                                  controller: fileCtrl,
                                  enabled: false,
                                  prefixIcon: SizedBox(
                                    child: Image.asset('assets/images/attach.png'),
                                  ),
                                  hintText: 'attach_file'.tr,


                                ),
                              ),
                              const SizedBox(height: 15,),
                              order == null ? SendButtonWidget(_sendData()) :  CancelUpdateWidget(
                                onUpdateRequest: _updateHoliday,
                                onCancelRequest: _cancelHolidayRequst,
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
          controller.loading.value ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: SendingLoadingWidget(),
            ),
          ):SizedBox(),
          controller.errorsList.isNotEmpty ? ErrorMessageWidget(errorList: controller.errorsList,onTap:(){
           ////
           controller.errorsList.clear();
         }): const SizedBox()
        ],
      )),
    );
  }

  _sendData() async {
    controller.loading.value = true;
    try{
      await controller.sendHolidayRequest();
      SnackBars.showConfirmedSnackBar('success'.tr, 'holiday_request_added'.tr);

      Future.delayed(Duration(milliseconds: 4600),(){
        Get.back();
      });
    }on StartDateException {
      println('StartDateException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'StartDateException'.tr);
    }on ChooseTypeException {
      println('HolidayTypeException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayTypeException'.tr);
    }on EndDateException{
      println('EndDateException ==== ');
      SnackBars.showErrorSnackBar('error'.tr, 'EndDateException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayReasonException'.tr);
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }finally{
      controller.loading.value = false;
    }
  }

  _updateHoliday() async{

     controller.loading.value = true;
     print('controller.filePath=-0=-0=-0=0=-0 ${controller.filePath}');
     //
     // return;

     try{
       println('update holiday request ${order?.orderID}');
       await controller.updateRequest('${order?.orderID}');
       SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
       Future.delayed(const Duration(milliseconds: 4600),(){
         if(onClose != null){
           onClose!();
         }
         Get.back();
       });
     }on StartDateException {
       println('StartDateException ==== ');
       SnackBars.showErrorSnackBar('error'.tr, 'StartDateException'.tr);
     }on ChooseTypeException {
       println('HolidayTypeException ==== ');
       SnackBars.showErrorSnackBar('error'.tr, 'HolidayTypeException'.tr);
     }on EndDateException{
       println('EndDateException ==== ');
       SnackBars.showErrorSnackBar('error'.tr, 'EndDateException'.tr);
     }on EnterReasonException{
       SnackBars.showErrorSnackBar('error'.tr, 'HolidayReasonException'.tr);
     }on NoInternetException catch(e){
       SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
     }on NoDataAvailableException catch(e){
       SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
     }finally{
       controller.loading.value = false;
     }
  }

  _cancelHolidayRequst() async{

    controller.loading.value = true;
    try{
      await controller.cancelRequest('${order?.orderID}');
      SnackBars.showConfirmedSnackBar('success'.tr, 'request_canceled'.tr);
      Future.delayed(const Duration(milliseconds: 4600),(){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      });
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, 'something_wrong_try_again'.tr);
    }finally{
      controller.loading.value = false;
    }
  }
}
