

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/holiday/holiday_request_controller.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/custom_exception.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/countries/country.dart';
import 'package:wassl/models/orders/holiday.dart';
import 'package:wassl/test_page.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/cancel_update.dart';
import 'package:wassl/views/pages/orders/pages/shared_widgets/send_button.dart';
import 'package:wassl/views/reusable_widgets/icons/chat_icon.dart';
import 'package:wassl/views/reusable_widgets/dialogs_messages/snack_bars.dart';
import '../../../../helpers/exceptions/date_exceptions.dart';
import '../../../../models/countries/city.dart';
import '../../../../models/orders/AllOrders.dart';
import '../../../../models/orders/order_type.dart';
import '../../../reusable_widgets/dialogs_messages/awsom_dialogs.dart';
import '../../../reusable_widgets/drop_down_widget.dart';
import '../../../reusable_widgets/error_message_widget.dart';
import '../../../reusable_widgets/icons/attach_icon.dart';
import '../../../reusable_widgets/icons/calendar_icon.dart';
import '../../../reusable_widgets/icons/location_icon.dart';
import '../../../reusable_widgets/icons/mony_on_hand.dart';
import '../../../reusable_widgets/icons/umbrella_icon.dart';
import '../../../reusable_widgets/localized_text.dart';
import '../../../reusable_widgets/main_appbar.dart';
import '../../../reusable_widgets/svg_widget.dart';
import '../../../reusable_widgets/textfield_with_icons.dart';

class HolidayRequestPage extends StatelessWidget {

  final controller = Get.put(HolidayRequestController());
  final startDateCtrl = TextEditingController();
  final endDateCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();
  final fileCtrl = TextEditingController();

  final Function? onClose;

  final Order? order;

  HolidayRequestPage({Key? key,this.onClose,this.order}) : super(key: key){
    setUpOrderData();
  }

  setUpOrderData() async{
    if(order != null){
      var holidayOrder = order as HolidaysData;
      startDateCtrl.text = holidayOrder.holidayStart ?? '';
      endDateCtrl.text = holidayOrder.holidayEnd ?? '';
      controller.selectedType = holidayOrder.type;

      if(controller.selectedType!.name.contains('عمل')){
        await controller.getAllCountries();
        controller.selectedCountry = holidayOrder.confirmation?.first.businessTrip?.country;
        await controller.getAllCities('${controller.selectedCountry?.id}');
        controller.selectedCity = holidayOrder.confirmation?.first.businessTrip?.region;
        controller.loadingCountries.value = true;
        controller.loadingCities.value = true;
      }
      reasonCtrl.text = holidayOrder.reason;
      fileCtrl.text = holidayOrder.file.split('/').last;
      var startDateArr = holidayOrder.holidayStart?.split('-');
      var endDateArr = holidayOrder.holidayEnd?.split('-');
      controller.startDate = DateTime(int.tryParse(startDateArr?[0] ?? '') ?? 0,int.tryParse(startDateArr?[1] ?? '') ?? 0,int.tryParse(startDateArr?[2] ?? '') ?? 0,);
      controller.endDate = DateTime(int.tryParse(endDateArr?[0] ?? '') ?? 0,int.tryParse(endDateArr?[1] ?? '') ?? 0,int.tryParse(endDateArr?[2] ?? '') ?? 0,);

      controller.holidayReason = holidayOrder.reason;
      controller.filePath = holidayOrder.file == '' ? null : holidayOrder.file;
      controller.setDifferenceInDays();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return Stack(
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
                      child: Container(
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
                            DropDownWidget<OrderType>(
                              hintText: 'holiday_type'.tr,
                              selectedValue: controller.selectedType,
                              items:  controller.orderTypes.value.data!.map((e) => e).toList(),
                              onSelectedIndex: (value) async {
                                controller.selectedType = value;
                                if(controller.selectedType?.name == 'رحلة عمل'){
                                  await controller.getAllCountries();
                                  controller.loadingCountries.value = true;
                                }else{
                                  controller.loadingCountries.value = false;
                                  controller.loadingCities.value = false;
                                  controller.selectedCountry = null;
                                }

                              },
                              prefixIcon: const SizedBox(
                                  width: 5,
                                  height: 35,
                                  child:UmbrellaIcon()),
                            ),

                            controller.loadingCountries.value ? Column(
                              children: [
                                const SizedBox(height: 15,),

                                DropDownWidget(
                                  hintText: 'select_country'.tr,
                                  selectedValue: controller.selectedCountry,
                                  items:  controller.countries.map((e) => e).toList(),
                                  onSelectedIndex: (value) async {
                                    controller.selectedCountry = value as Country?;
                                    await controller.getAllCities('${controller.selectedCountry?.id}');
                                    controller.loadingCities.value = true;
                                    controller.setDifferenceInDays();
                                  },
                                  iconPadding: 16,
                                  prefixIcon: const SizedBox(
                                    // width: 5,
                                    // height: 5,
                                      child:
                                      LocationIcon()),
                                ) ,
                                const SizedBox(height: 15,),

                                controller.loadingCities.value ?
                                DropDownWidget(
                                  hintText: 'select_city'.tr,
                                  selectedValue: controller.selectedCity,
                                  items:  controller.cities.map((e) => e).toList(),
                                  onSelectedIndex: (value) {
                                    controller.selectedCity = value as City?;
                                    controller.setDifferenceInDays();
                                  },
                                  iconPadding: 16,
                                  prefixIcon: const SizedBox(
                                    // width: 5,
                                    // height: 5,
                                      child:
                                      LocationIcon()),
                                ) : const SizedBox(),
                              ],
                            ): const SizedBox(),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                Expanded(child: InkWell(
                                  onTap: () async {
                                    var selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
                                    controller.startDate = selectedDate ?? controller.startDate;
                                    if(controller.startDate != null){
                                      startDateCtrl.text = '${controller.startDate?.year}-${controller.startDate?.month}-${controller.startDate?.day} ';
                                      controller.setDifferenceInDays();
                                    }else{
                                      startDateCtrl.text = '';
                                    }
                                  },
                                  child:TextFormFieldWithIcons(
                                    prefixIcon: const PrefCalendarIcon(),
                                    hintText: 'start'.tr,
                                    enabled: false,
                                    controller: startDateCtrl,
                                  ),

                                ),),
                                const SizedBox(width: 16,),
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
                                    prefixIcon: const PrefCalendarIcon(),
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
                                          const SizedBox(width: 16,),
                                          SizedBox(
                                            width: 25,
                                            child: Image.asset('assets/images/order_details/arrow.png'),
                                          ),
                                          const SizedBox(width: 16,),
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
                            ) : const SizedBox(),

                            controller.tripCost.value.trip != null ? Column(
                              children: [
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      child: SalaryMoneyOnHandIcon(),
                                    ),
                                    const SizedBox(width: 16,),
                                    Text('cost_per_day'.tr,style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    const Text(' : '),
                                    Expanded(

                                      child: Text('${controller.tripCost.value.trip?.costPerDay}  ${'SAR'.tr}',style: const TextStyle(
                                          color: AppColors.darkGreyTextColor,
                                          fontSize: 16
                                      ),),
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      child: SalaryMoneyOnHandIcon(),
                                    ),
                                    const SizedBox(width: 16,),
                                    Text('total_cost'.tr,style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    const Text(' : '),
                                    Expanded(

                                      child: Text('${controller.tripCost.value.totalCost}  ${'SAR'.tr}',style: const TextStyle(
                                          color: AppColors.darkGreyTextColor,
                                          fontSize: 16
                                      ),),
                                    ),

                                  ],
                                ),
                              ],
                            ) : const SizedBox(),

                            const SizedBox(height: 15,),
                            // DropDownMenu(textHint: 'loan_type'.tr,)




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
                                prefixIcon: const AttachmentIcon(),
                                hintText: 'attach_file'.tr,


                              ),
                            ),
                            const SizedBox(height: 15,),
                            order == null ? SendButtonWidget(_sendData) :  CancelUpdateWidget(
                              onUpdateRequest: _updateHoliday,
                              onCancelRequest: _cancelHolidayRequest,
                            ),
                            const SizedBox(height: 25,),
                          ],
                        ),
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
        );
      }),
    );
  }

  _sendData(context) async {
    controller.loading.value = true;
    try{
      await controller.sendHolidayRequest();

      successDialog(context,message: 'holiday_request_added'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );


    }on StartDateException {
      SnackBars.showErrorSnackBar('error'.tr, 'StartDateException'.tr);

    }on ChooseTypeException {
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayTypeException'.tr);
    }on EndDateException{
      SnackBars.showErrorSnackBar('error'.tr, 'EndDateException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayReasonException'.tr);
    }on NoInternetException catch(e){
      errorDialog(context,message: e.errorMessage);
    }on NoDataAvailableException catch(e){
      errorDialog(context,message: 'something_wrong_try_again'.tr);
    }on CustomException catch(e){
      errorDialog(context,message: e.errorMessage);
    }finally{
      controller.loading.value = false;
    }
  }

  _updateHoliday(context) async{

    controller.loading.value = true;

    try{
      await controller.updateRequest('${order?.orderID}');
      // SnackBars.showConfirmedSnackBar('success'.tr, 'request_updated'.tr);
      successDialog(context,message: 'request_updated'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );

    }on StartDateException {
      SnackBars.showErrorSnackBar('error'.tr, 'StartDateException'.tr);
    }on ChooseTypeException {
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayTypeException'.tr);
    }on EndDateException{
      SnackBars.showErrorSnackBar('error'.tr, 'EndDateException'.tr);
    }on EnterReasonException{
      SnackBars.showErrorSnackBar('error'.tr, 'HolidayReasonException'.tr);
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      errorDialog(context,message: 'something_wrong_try_again'.tr);
    }finally{
      controller.loading.value = false;
    }
  }

  _cancelHolidayRequest(context) async{

    controller.loading.value = true;
    try{
      await controller.cancelRequest('${order?.orderID}');
      successDialog(context,message: 'request_canceled'.tr,onPress: (){
        if(onClose != null){
          onClose!();
        }
        Get.back();
      }
      );
    }on NoInternetException catch(e){
      SnackBars.showErrorSnackBar('error'.tr, e.errorMessage);
    }on NoDataAvailableException catch(e){
      errorDialog(context,message: 'something_wrong_try_again'.tr);
    }finally{
      controller.loading.value = false;
    }
  }
}

